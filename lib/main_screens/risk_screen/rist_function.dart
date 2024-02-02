class RiskFunction {
  static List<Map<String, dynamic>> questions = [
    {
      'title': 'Family',
      'question':
          "Did any of your close family members (brother, father or uncle on your father’s or mother’s side) suffer of prostate cancer now or in the past?",
      'option': 2,
      'options': [
        {'option': 'yes', 'score': 70},
        {'option': 'no', 'score': 10},
      ],
    },
    {
      'title': 'Age',
      'question': "To which age group do you belong?",
      'option': 4,
      'options': [
        {'option': '55 - 59 years', 'score': 10},
        {'option': '60 - 64 years', 'score': 20},
        {'option': '65 - 70 years', 'score': 50},
        {'option': '70 - 74 years', 'score': 80},
      ],
    },
    {
      'title': 'Urinary',
      'question':
          "In order to completely evaluate your pattern of voiding your urine, it is necessary to answer these 7 questions in sequence. The questions you are asked to answer, are part of the validated international prostate symptoms scores (IPSS).\nHow often have you had a sensation of not emptying your bladder completely after you finished urinating?",
      'option': 6,
      'options': [
        {'option': 'Never', 'score': 10},
        {'option': 'About 1 time in 5', 'score': 20},
        {'option': 'About 1 time in 3', 'score': 50},
        {'option': 'About 1 time in 2', 'score': 50},
        {'option': 'About 2 time in 3', 'score': 80},
        {'option': 'Almost always', 'score': 95},
      ],
    },
    {
      'title': 'Urinary',
      'question':
          ' How often have you had to urinate again less then two hours after you finished urinating?',
      'option': 6,
      'options': [
        {'option': 'Never', 'score': 10},
        {'option': 'About 1 time in 5', 'score': 20},
        {'option': 'About 1 time in 3', 'score': 50},
        {'option': 'About 1 time in 2', 'score': 50},
        {'option': 'About 2 time in 3', 'score': 80},
        {'option': 'Almost always', 'score': 95},
      ],
    },
    {
      'title': 'Urinary',
      'question':
          'How often have you found it difficult tohold back urinating after you have felt the need?',
      'option': 6,
      'options': [
        {'option': 'Never', 'score': 10},
        {'option': 'About 1 time in 5', 'score': 20},
        {'option': 'About 1 time in 3', 'score': 50},
        {'option': 'About 1 time in 2', 'score': 50},
        {'option': 'About 2 time in 3', 'score': 80},
        {'option': 'Almost always', 'score': 95},
      ],
    },
    {
      'title': 'Urinary',
      'question':
          'How often have you noticed a reduction in the strengthand force of your urinary stream?',
      'option': 6,
      'options': [
        {'option': 'Never', 'score': 10},
        {'option': 'About 1 time in 5', 'score': 20},
        {'option': 'About 1 time in 3', 'score': 50},
        {'option': 'About 1 time in 2', 'score': 50},
        {'option': 'About 2 time in 3', 'score': 80},
        {'option': 'Almost always', 'score': 95},
      ],
    },
    {
      'title': 'Urinary',
      'question':
          'How often have you had to push or strain to begin urinating?',
      'option': 6,
      'options': [
        {'option': 'Never', 'score': 10},
        {'option': 'About 1 time in 5', 'score': 20},
        {'option': 'About 1 time in 3', 'score': 50},
        {'option': 'About 1 time in 2', 'score': 50},
        {'option': 'About 2 time in 3', 'score': 80},
        {'option': 'Almost always', 'score': 95},
      ],
    },
    {
      'title': 'Urinary',
      'question':
          'How many times do you have to get up from bed to urinate after going to sleep',
      'option': 6,
      'options': [
        {'option': 'Never', 'score': 10},
        {'option': 'Once', 'score': 20},
        {'option': 'Twice', 'score': 50},
        {'option': 'Three times', 'score': 50},
        {'option': 'Four times', 'score': 80},
        {'option': 'A lot', 'score': 95},
      ],
    },
  ];
}
