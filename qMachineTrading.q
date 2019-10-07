\l trade1.q
\l qbitmex.q

settings1:`apiHost`apiKey`apiSecret!("www.bitmex.com";"api-key";"api-secret");

states1:`momentum`volatility`upxsma`downxsma`RSI`volume;

// step 1, update local data store
updateData:{[]
	load`trades;
	lasttime: exec last time from trades;
	h:hopen`::5010;
	`trades insert (h"" sv ("select from trades where time > ";string lasttime));
	hclose h;}

// step 2, create candlestick binned data.
candles:{[]
    update size: 0.0-size from `trades where side like "seller";
	select date: time,o,h,l,c,v,close from select o:first price,h:max price,l:min price,c:last price,v:sum size,close:last price by 00:15:00.000000 xbar time from trades};

mavg1:{a:sum[x#y]%x; b:(x-1)%x; a,a b\(x+1)_y%x};
calcRsi:{100*rs%1+rs:mavg1[x;y*y>0]%mavg1[x;abs y*(y:y-prev y)<0]};

// step 3, add indicators to local candlestick data
indicators1:{[data]
	data:update
  	rsi:((10#0Nf),calcRsi[10;close]),
	  momentum:{(x>=0)} -1+close%close[i-5],
	  vol:0^5 mdev log close%close[i-1],
    rate:msum[20;v],
	  macd:(ema[2%41;close])-ema[2%71;close],
	  signal:ema[2%61;(ema[2%41;close])-ema[2%71;close]],
	  rtn5:-1+close[i+5]%close from data;
   data:update RSI:(80 <) each rsi from data;
   data:update RSI:(20 >) each rsi from data;
	 data:update volatility:(med[vol] <) each vol from data;
	 data:update volume:(0 <) each rate from data;
	 data:update xsma:{(x>=0)-x<0} macd-signal from data;
	 data:update xsma:0^xsma-xsma[i-1] from data;
	 data:update downxsma:.trading.swin[{any x<0};5;xsma],
	  upxsma:.trading.swin[{any x>0};5;xsma] from data;data}

// step 4, train learning states, select best stored state based on back-test returns
learning:{[data]
	getreturns["BTDUSD";2];resy}
//store:resy;

// step 5, get current data for live trading
liveTrading:{[store1;data]
	current:-2#data;
	//position:getpos[];
  position: r:restapi[settings1`apiHost;"GET";"/api/v1/position";"";settings1`apiKey;settings1`apiSecret];
	position:select from position`body where symbol like "XBTUSD";
  rprev: first current;
  r:last current;
	qty:10;
	rprev[`side]:1b;
	if[0 < count position; $[0 < first position[`currentQty];[rprev[`side]:1b;qty:20];[rprev[`side]:0b;qty:20]]];
	if[0D00:35:00.000000 > .z.p - r`date;
	 prevside: rprev`side;
	 curstate:(`side,states1)!(prevside,r[states1]);
	 action:.qlearner.best_action[store1;curstate];
	 side:prevside;
	 if[(action=`long)&(prevside=0b);side:1b];
	 if[(action=`short)&(prevside=1b);side:0b];
	 newstate:curstate,enlist[`side]!enlist[side];
	 r[`side]:side;
	 if[side<>last rprev`side;
	    $[action~`long; b x:`XBTUSD,qty; s x:`XBTUSD,qty];
	 ];
	];}

updateData[];
data:candles[];
data:indicators1[data];
store1:learning[data];


lu:0;
.z.ts:{[]updateData[];data:candles[];data:indicators1[data];liveTrading[store1;data];lu::lu+1;}

\t 900000
