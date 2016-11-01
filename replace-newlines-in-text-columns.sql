update dbo.twbCCR
set RecommendationsTxt = REPLACE(convert(varchar(max),RecommendationsTxt), CHAR(13),'')
select replace(convert(nvarchar(max), RecommendationsTxt), CHAR(10),'') as RecommendationsTxt from dbo.twbCCR