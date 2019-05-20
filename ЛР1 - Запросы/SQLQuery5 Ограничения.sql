USE [Universitys]
GO

ALTER TABLE [dbo].[University] ADD  CONSTRAINT [DF_University_City]  DEFAULT (N'Пермь') FOR [City]
GO

ALTER TABLE [dbo].[University] ADD  CONSTRAINT [DF_University_University] UNIQUE (University)
GO

