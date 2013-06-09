@account
Feature: User account orders page
  In order to follow my orders
  As a logged user
  I want to be able to track and get an invoice of my sent orders

  Background:
    Given I am logged in user
    And I am on my account homepage

    And the following zones are defined:
      | name         | type    | members                   |
      | Scandinavia | country | Norway, Sweden, Finland |
      | France       | country | France                    |
      | USA          | country | USA                        |
    And there are following shipping categories:
      | name    |
      | Regular |
      | Heavy   |
    And the following shipping methods exist:
      | category | zone          | name    |
      | Regular  | Scandinavia  | DHL     |
      | Heavy    | USA           | FedEx   |
      |           | France       | UPS     |
    And the following products exist:
      | name          | price | sku |
      | Mug           | 5.99   | 456 |
      | Sticker       | 10.00 | 213 |
      | Book          | 22.50 | 948 |
    And the following orders exist:
      | user           | shipment  | address                                                                  |
      | username       | UPS       | Théophile Morel, 17 avenue Jean Portalis, 33000, Bordeaux, France  |
      | ianmurdock     | FedEx     | Ian Murdock, 3569 New York Avenue, CA 92801, San Francisco, USA   |
      | ianmurdock     |           | Ian Murdock, 3569 New York Avenue, CA 92801, San Francisco, USA   |
      | linustorvalds  | DHL      | Linus Torvalds, Väätäjänniementie 59, 00440, Helsinki, Finland      |
      | linustorvalds  | DHL      | Linus Torvalds, Väätäjänniementie 59, 00440, Helsinki, Finland      |
      | username       |           | Théophile Morel, 17 avenue Jean Portalis, 33000, Bordeaux, France  |
      | username       | UPS       | Théophile Morel, 17 avenue Jean Portalis, 33000, Bordeaux, France  |
      | linustorvalds  |           | Linus Torvalds, Väätäjänniementie 59, 00440, Helsinki, Finland     |
      | username       | UPS       | Théophile Morel, 17 avenue Jean Portalis, 33000, Bordeaux, France  |
      | username       | UPS       | Théophile Morel, 17 avenue Jean Portalis, 33000, Bordeaux, France  |
      | ianmurdock     | FedEx    | Ian Murdock, 3569 New York Avenue, CA 92801, San Francisco, USA   |
    # order that has been sent
    And order #000001 has following items:
      | product  | quantity  |
      | Mug      | 2          |
      | Sticker  | 4          |
      | Book     | 1          |
    # order that has not been sent yet
    And order #000007 has following items:
      | product  | quantity  |
      | Mug      | 5          |
      | Sticker  | 1          |

  Scenario: Viewing my account orders page
    Given I follow "My orders / my invoices"
    Then I should be on my account orders page

  Scenario Outline: Viewing my orders
    Given I am on my account orders page
     Then I should see "All your orders"
      And I should see 5 orders in the list
      And I should see "<myorder>"
      And I should not see "<order>"

    Examples:
      | myorder  | order     |
      | #000001 | #000002  |
      | #000006 | #000003  |
      | #000007 | #000004  |
      | #000009 | #000005  |
      | #000010 | #000008  |
      | #000010 | #000011  |

  Scenario Outline: Viewing the detail of an order
    Given I am on my account orders page
      And I follow "order<order>Details"
     Then I should see "Details of your order"
      And I should be on the order page for <order>
      And I should see <items> items in the list

    Examples:
      | order    | items |
      | #000001 | 3     |
      | #000007 | 2     |

  Scenario Outline: Trying to view the detail of an order which is not mine
    Given I am on my account orders page
      And I go to the order page for <order>
     Then the response status code should be 403

  Examples:
      | order    |
      | #000002 |
      | #000003 |
      | #000004 |
      | #000005 |
      | #000008 |
      | #000011 |

  Scenario: Tracking an order that has been sent
  Scenario: Trying to track an order that has not been sent
  Scenario: Generating an invoice for an order that has been sent
  Scenario: Trying to generate an invoice for an order that has not been sent
  Scenario: Accessing an item from the detail of an order
  Scenario: Trying to access an inactive or deleted item from the detail of an order



