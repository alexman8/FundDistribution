# Fund Distribution

Given an amount of funding and a group of participants, write a method `distribute_fund` to distribute it among the participants as even as possible:

- Each participant has a name and a definite amount owed. One shall not pay a participant more than the amount that is owed
- The unit of the funding is a whole number. It is in the smallest unit of the currency and indivisible (e.g. U.S. cent)
- Evenly distributing the fund takes priority over paying any subset of the participants in full. If the fund is not enough for each participant to receive a payment, the participants shall be paid in an alphabetically order of their name one unit of currency at a time until the fund is exhausted

Please return a hash representing the distributions in the following format:

`{'participant_1' => distribution_1, 'participant_2' => distribution_2, ... }`