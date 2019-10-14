# qMachineTrader

Q Learning is a reinforcement learning method for incrementally estimating the optimal action-value function. It is an off-policy temporal difference method. As such, it is model-free and uses bootstrapping.

Word to the wise. Machine learning is only as smart as it's designer and can only be optimised for historic events. Moreover, it can never harness human intuition, product integrity or longevity. I would use this only for guidance.

This script is designed to be used in conjunction with qMonitorBTCUSD (https://github.com/sandybradley/qMonitor/blob/master/qmonitorBTCUSD.q). That needs to be running for a while to get some meaningful backtest learning. Automated trading takes place on Bitmex.

# Pre-requisites

KDB+ (https://kx.com/connect-with-us/download/)

Bitmex account https://www.bitmex.com/register/L6zctF

# Run learning and start automated trading

Edit your api credentials in qMachineTrader.q. Ensure qMonitorBTCUSD has been running for a long time. Then start the script with a new q instance.

\l qMachineTrader.q

The learner will iterate backtests to form a decision matrix based on the programmed bit-field states. This takes a while. After that, it will select the best performing matrix and apply it to current market conditions for automated trading. This project is entirely experimental. You are most likely to lose money.

# Karma jar

BTC - 112eMCQJUkUz7kvxDSFCGf1nnFJZ61CE4W

LTC - LR3BfiS77dZcp3KrEkfbXJS7U2vBoMFS7A

ZEC - t1bQpcWAuSg3CkBs29kegBPXvSRSaHqhy2b

XLM - GAHK7EEG2WWHVKDNT4CEQFZGKF2LGDSW2IVM4S5DP42RBW3K6BTODB4A Memo: 1015040538

Nano - nano_1ca5fxd7uk3t61ghjnfd59icxg4ohmbusjthb7supxh3ufef1sykmq77awzh

XRP - rEb8TK3gBgk5auZkwc6sHnwrGVJH8DuaLh Tag: 103535357

EOS - binancecleos Memo: 103117718

# Recommended links

Getting started - Coinbase - https://www.coinbase.com/join/bradle_6r

Portfolio balance - Binance - www.binance.com/en/register?ref=LTUMGDDC

Futures trading - Deribit - https://www.deribit.com/reg-8106.6912

Cold wallet - https://atomicWallet.io?kid=12GR52 (promo 12GR52) - https://hodler.tech/

Learn to earn (coinbase users) - Stellar - https://coinbase.com/earn/xlm/invite/vps5dfzt - EOS - https://coinbase.com/earn/eos/invite/xdbgswqk
