# world

## city
### テーブル定義
| 列名 | デフォルト | NULL | 型 | キー | その他 | コメント 
|---|---|---|---|---|---|---|
| ID| | NO| int(11)| PRI| auto_increment| |
| Name| | NO| char(35)| | | |
| CountryCode| | NO| char(3)| MUL| | |
| District| | NO| char(20)| | | |
| Population| 0| NO| int(11)| | | |

### INDEX情報
| INDEX名 | INDEX列 | UNIQUE |コメント | 
|---|---|---|---|
| CountryCode| CountryCode| | |
| PRIMARY| ID| UNIQUE| |

## country
### テーブル定義
| 列名 | デフォルト | NULL | 型 | キー | その他 | コメント 
|---|---|---|---|---|---|---|
| Code| | NO| char(3)| PRI| | |
| Name| | NO| char(52)| | | |
| Continent| Asia| NO| enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America')| | | |
| Region| | NO| char(26)| | | |
| SurfaceArea| 0.00| NO| decimal(10,2)| | | |
| IndepYear| | YES| smallint(6)| | | |
| Population| 0| NO| int(11)| | | |
| LifeExpectancy| | YES| decimal(3,1)| | | |
| GNP| | YES| decimal(10,2)| | | |
| GNPOld| | YES| decimal(10,2)| | | |
| LocalName| | NO| char(45)| | | |
| GovernmentForm| | NO| char(45)| | | |
| HeadOfState| | YES| char(60)| | | |
| Capital| | YES| int(11)| | | |
| Code2| | NO| char(2)| | | |

### INDEX情報
| INDEX名 | INDEX列 | UNIQUE |コメント | 
|---|---|---|---|
| PRIMARY| Code| UNIQUE| |

## countrylanguage
### テーブル定義
| 列名 | デフォルト | NULL | 型 | キー | その他 | コメント 
|---|---|---|---|---|---|---|
| CountryCode| | NO| char(3)| PRI| | |
| Language| | NO| char(30)| PRI| | |
| IsOfficial| F| NO| enum('T','F')| | | |
| Percentage| 0.0| NO| decimal(4,1)| | | |

### INDEX情報
| INDEX名 | INDEX列 | UNIQUE |コメント | 
|---|---|---|---|
| CountryCode| CountryCode| | |
| PRIMARY| CountryCode,Language| UNIQUE| |
