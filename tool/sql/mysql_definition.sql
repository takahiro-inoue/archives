-- Mysql テーブル、INDEX定義マークダウン出力
SELECT
  CONCAT( 
    COLUMN_NAME
    , COLUMN_DEFAULT
    , IS_NULLABLE
    , COLUMN_TYPE
    , COLUMN_KEY
    , EXTRA
    , COLUMN_COMMENT
  ) AS Markdown 
FROM
  ( 
    SELECT
      '' AS TABLE_NAME
      , CONCAT('\r\n# ', schema_name) AS COLUMN_NAME
      , '' AS COLUMN_DEFAULT
      , '' AS IS_NULLABLE
      , '' AS COLUMN_TYPE
      , '' AS COLUMN_KEY
      , '' AS EXTRA
      , '' AS COLUMN_COMMENT
      , '-99' AS ORDINAL_POSITION 
    FROM
      information_schema.schemata 
    WHERE
      schema_name = database() 
    UNION ALL 
    SELECT
      TABLE_NAME
      , CONCAT('\r\n## ', TABLE_NAME, '\r\n### テーブル定義') AS COLUMN_NAME
      , CONCAT('（', TABLE_COMMENT, '）') AS COLUMN_DEFAULT
      , '' AS IS_NULLABLE
      , '' AS COLUMN_TYPE
      , '' AS COLUMN_KEY
      , '' AS EXTRA
      , '' AS COLUMN_COMMENT
      , '-2' AS ORDINAL_POSITION 
    FROM
      information_schema.tables 
    WHERE
      table_schema = database() 
    UNION ALL 
    SELECT
      TABLE_NAME
      , '| 列名 ' AS COLUMN_NAME
      , '| デフォルト ' AS COLUMN_DEFAULT
      , '| NULL ' AS IS_NULLABLE
      , '| 型 ' AS COLUMN_TYPE
      , '| キー ' AS COLUMN_KEY
      , '| その他 ' AS EXTRA
      , '| コメント ' AS COLUMN_COMMENT
      , '-1' AS ORDINAL_POSITION 
    FROM
      information_schema.tables 
    WHERE
      table_schema = database() 
    UNION ALL 
    SELECT
      TABLE_NAME
      , '|---' AS COLUMN_NAME
      , '|---' AS COLUMN_DEFAULT
      , '|---' AS IS_NULLABLE
      , '|---' AS COLUMN_TYPE
      , '|---' AS COLUMN_KEY
      , '|---' AS EXTRA
      , '|---|' AS COLUMN_COMMENT
      , '0' AS ORDINAL_POSITION 
    FROM
      information_schema.tables 
    WHERE
      table_schema = database() 
    UNION ALL 
    SELECT
      TABLE_NAME
      , CONCAT('| ', COLUMN_NAME)
      , CONCAT('| ', IFNULL(COLUMN_DEFAULT, ''))
      , CONCAT('| ', IS_NULLABLE)
      , CONCAT('| ', COLUMN_TYPE)
      , CONCAT('| ', COLUMN_KEY)
      , CONCAT('| ', EXTRA)
      , CONCAT('| ', COLUMN_COMMENT, '|')
      , ORDINAL_POSITION 
    FROM
      information_schema.columns 
    WHERE
      table_schema = database() 
    UNION ALL 
    SELECT
      DISTINCT
      TABLE_NAME
      , '\r\n### INDEX情報\r\n| INDEX名 ' AS COLUMN_NAME
      , '| INDEX列 ' AS COLUMN_DEFAULT
      , '| UNIQUE ' AS IS_NULLABLE
      , '|コメント |' AS COLUMN_TYPE
      , '' AS COLUMN_KEY
      , ' ' AS EXTRA
      , '' AS COLUMN_COMMENT
      , '1001' AS ORDINAL_POSITION 
    FROM
      information_schema.statistics 
    WHERE
      table_schema = database() 
    UNION ALL 
    SELECT
      DISTINCT
      TABLE_NAME
      , '|---' AS COLUMN_NAME
      , '|---' AS COLUMN_DEFAULT
      , '|---' AS IS_NULLABLE
      , '|---|' AS COLUMN_TYPE
      , '' AS COLUMN_KEY
      , '' AS EXTRA
      , '' AS COLUMN_COMMENT
      , '1002' AS ORDINAL_POSITION 
    FROM
      information_schema.statistics 
    WHERE
      table_schema = database() 
    UNION ALL 
    SELECT
      TABLE_NAME
      , CONCAT('| ', INDEX_NAME) AS COLUMN_NAME
      , CONCAT( 
        '| '
        , GROUP_CONCAT(COLUMN_NAME ORDER BY SEQ_IN_INDEX)
      ) AS COLUMN_DEFAULT
      , CONCAT('| ', IF (NON_UNIQUE = 0, 'UNIQUE', '')) AS IS_NULLABLE
      , CONCAT('| ', COMMENT, '|') AS COLUMN_TYPE
      , '' AS COLUMN_KEY
      , '' AS EXTRA
      , '' AS COLUMN_COMMENT
      , '1003' AS ORDINAL_POSITION 
    FROM
      information_schema.statistics 
    WHERE
      table_schema = database() 
    GROUP BY
      TABLE_NAME
      , INDEX_NAME
  ) temp 
ORDER BY
  TABLE_NAME
  , CAST(ORDINAL_POSITION AS SIGNED);
