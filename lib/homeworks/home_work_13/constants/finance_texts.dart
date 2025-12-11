class FinanceTexts {
  const FinanceTexts._();

  static const transactionsTab = 'Транзакції';
  static const analyticsTab = 'Аналітика';
  static const settingsTab = 'Налаштування';

  static const addTransactionTitle = 'Нова транзакція';
  static const amountLabel = 'Сума';
  static const descriptionLabel = 'Опис';
  static const categoryLabel = 'Категорія';
  static const dateLabel = 'Дата';
  static const typeLabel = 'Тип';
  static const income = 'Дохід';
  static const expense = 'Витрата';
  static const saveButton = 'Зберегти';
  static const deleteTransactionTooltip = 'Видалити транзакцію';

  static const budgetLimitLabel = 'Місячний бюджет';
  static const currencyLabel = 'Валюта';
  static const settingsSaveButton = 'Оновити налаштування';

  static const emptyTransactions =
      'Ще немає жодного запису. Додайте першу транзакцію!';
  static const totalExpensesLabel = 'Витрати цього місяця';
  static const totalIncomeLabel = 'Доходи цього місяця';
  static const balanceLabel = 'Баланс';
  static const budgetUsageLabel = 'Використано бюджету';
  static const topCategoriesLabel = 'Найактивніші категорії';
  static const noAnalyticsData = 'Недостатньо даних для аналітики';
}

class FinanceCategories {
  const FinanceCategories._();

  static const defaultCategories = <String>[
    'Харчування',
    'Транспорт',
    'Розваги',
    'Комунальні',
    'Здоровʼя',
    'Освіта',
    'Покупки',
    'Інше',
  ];

  static const currencyOptions = <String>['UAH', 'USD', 'EUR', 'PLN'];
}
