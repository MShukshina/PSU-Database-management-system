USE [master]
GO
/****** Object:  Database [Universitys]    Script Date: 23.01.2018 13:01:34 ******/
CREATE DATABASE [Universitys]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Universitys', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQL_SERVER\MSSQL\DATA\Universitys.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Universitys_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQL_SERVER\MSSQL\DATA\Universitys_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Universitys] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Universitys].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Universitys] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Universitys] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Universitys] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Universitys] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Universitys] SET ARITHABORT OFF 
GO
ALTER DATABASE [Universitys] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Universitys] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Universitys] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Universitys] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Universitys] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Universitys] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Universitys] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Universitys] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Universitys] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Universitys] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Universitys] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Universitys] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Universitys] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Universitys] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Universitys] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Universitys] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Universitys] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Universitys] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Universitys] SET  MULTI_USER 
GO
ALTER DATABASE [Universitys] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Universitys] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Universitys] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Universitys] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Universitys]
GO
/****** Object:  Table [dbo].[Citys]    Script Date: 23.01.2018 13:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Citys](
	[city_id] [int] IDENTITY(1,1) NOT NULL,
	[city] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Citys] PRIMARY KEY CLUSTERED 
(
	[city_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fakultys]    Script Date: 23.01.2018 13:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fakultys](
	[fakulty_id] [int] IDENTITY(1,1) NOT NULL,
	[university_id] [int] NOT NULL,
	[fakulty] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Fakulty] PRIMARY KEY CLUSTERED 
(
	[fakulty_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 23.01.2018 13:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[student_id] [int] IDENTITY(1,1) NOT NULL,
	[surname] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[patronymic] [nvarchar](50) NULL,
	[fakulty_id] [int] NOT NULL,
	[course] [int] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[University]    Script Date: 23.01.2018 13:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[University](
	[university_id] [int] IDENTITY(1,1) NOT NULL,
	[university] [nvarchar](50) NOT NULL,
	[city_id] [int] NOT NULL,
 CONSTRAINT [PK_University] PRIMARY KEY CLUSTERED 
(
	[university_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Citys] ON 

INSERT [dbo].[Citys] ([city_id], [city]) VALUES (1, N'Пермь')
SET IDENTITY_INSERT [dbo].[Citys] OFF
SET IDENTITY_INSERT [dbo].[Fakultys] ON 

INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (3, 1, N'Механико-математический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (4, 1, N'Экономический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (6, 1, N'Химический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (8, 1, N'Географический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (9, 1, N'Юридический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (10, 1, N'Философско-социологический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (11, 1, N'Филологический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (14, 1, N'Историко-политологический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (46, 1, N'Геологический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (48, 1, N'Биологический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (49, 1, N'Физический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (50, 2, N'Автодорожный')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (51, 2, N'Аэрокосмический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (52, 2, N'Горно-нефтяной')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (53, 2, N'Гуманитарный')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (56, 2, N'Механико-технологический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (57, 2, N'Строительный')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (58, 2, N'Химико-технологический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (60, 2, N'Электротехнический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (61, 2, N'Прикладная математика и механика')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (62, 3, N'Математический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (63, 3, N'Филологический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (64, 3, N'Физической культуры')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (65, 3, N'Естественнонаучный')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (66, 3, N'Иностранных языков')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (67, 3, N'Физический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (68, 3, N'Исторический')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (69, 3, N'Музыки')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (70, 3, N'Информатики и экономики')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (71, 3, N'Педагогики и методики начального образования')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (72, 3, N'Педагогики и психологии детства')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (73, 4, N'Медико-профилактическое дело')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (74, 4, N'Педиатрия')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (75, 4, N'Лечебное дело')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (76, 4, N'Стоматология')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (77, 4, N'Сестринское дело')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (78, 4, N'Клиническая психилогия')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (79, 5, N'Архитектурно-строительный')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (80, 5, N'Инженерный')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (81, 5, N'Агротехнологий и лесного хозяйства')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (83, 5, N'Ветеринарной медицины и зоотехники')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (84, 5, N'Землеустройства и кадастра')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (85, 5, N'Почвоведения, агрохимии, экологии и товароведения')
INSERT [dbo].[Fakultys] ([fakulty_id], [university_id], [fakulty]) VALUES (86, 5, N'Экономики,финансов и коммерции')
SET IDENTITY_INSERT [dbo].[Fakultys] OFF
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (5, N'Шукшина', N'Мария', N'Ивановна', 3, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (6, N'Гришина', N'Анастасия', N'Андреевна', 4, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (7, N'Суворов ', N'Андрей ', N'Михайлович', 49, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (8, N'Гуменюк ', N'Екатерина', N'Александровна', 11, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (9, N'Мелюхина', N'Ольга', N'Андреевна', 9, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (10, N'Пашиева', N'Снежанна', N'Сергеевна', 11, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (11, N'Нахратова', N'Виктория', N'Александровна', 8, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (12, N'Моторина', N'Дарья', N'Михайловна', 48, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (13, N'Игошева', N'Татьяна', N'Александровна', 6, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (14, N'Дебрина', N'Ангелина', N'Дмитриевна', 10, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (15, N'Пришвин', N'Петр', N'Витальевич', 46, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (16, N'Витас', N'Федор', N'Данилович', 14, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (18, N'Антонов', N'Антон ', N'Игоревич', 86, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (19, N'Болгов', N'Артем', N'Игоревич', 66, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (20, N'Васильев', N'Денис', N'Филиппович', 76, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (21, N'Васильева', N'Наталья', N'Васильевна', 61, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (31, N'Волова ', N'Анна', N'Дмитриевна', 83, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (33, N'Дакучаева ', N'Кристина', N'Алексеевна', 85, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (34, N'Зеленов ', N'Владимир', N'Эдуардович', 75, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (35, N'Коновалова ', N'Арина', N'Александровна', 76, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (36, N'Коробей', N'Анастасия', N'Александровна', 84, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (37, N'Кубарев', N'Иаван', N'Алексеевич', 81, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (38, N'Матвеева', N'Мария', N'Евгеньевна', 74, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (39, N'Нопин', N'Данил', N'Александрович', 70, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (40, N'Пегасин', N'Кристиан', N'Иванович', 69, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (41, N'Пузырев', N'Дмитрий', N'Владимирович', 67, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (42, N'Смирнов', N'Артем', N'Игоревич', 65, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (43, N'Яковлева', N'Ульяна', N'Владимировна', 51, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (44, N'Борисова', N'Анастасия', N'Витальевна', 58, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (45, N'Ким', N'Александр', N'Павлович', 56, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (46, N'Кузнецов', N'Никита', N'Андреевич', 60, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (47, N'Малков', N'Андрей', N'Сергеевич', 53, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (48, N'Русов ', N'Максим', N'Андреевич', 52, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (49, N'Сасова', N'Кристина', N'Олеговна', 56, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (50, N'Ярошенко', N'Дарья', N'Денисовна', 57, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (51, N'Гукун', N'Яна', N'Евгеньевна', 61, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (52, N'Иванова', N'Елизавета', N'Сергеевна', 65, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (53, N'Гукун', N'Яна', N'Евгеньевна', 61, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (54, N'Иванова', N'Елизавета', N'Сергеевна', 65, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (56, N'Куркова', N'Дарья', N'Игоревна', 50, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (57, N'Лопатко', N'Алексей', N'Алексеевич', 62, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (58, N'Маркина', N'Анна', N'Дмитриевна', 63, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (61, N'Ситников ', N'Евгений', N'Игореивч', 64, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (62, N'Ульянова', N'Марина', N'Алексеевна', 68, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (63, N'Абрамова', N'Жанна', N'Сергеевна', 80, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (65, N'Карпова', N'Анастасия', N'Серргеевна', 71, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (66, N'Мануков', N'Антон', N'Борисович', 72, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (67, N'Мешкова', N'Людмила ', N'Николаевна', 78, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (68, N'Новиков', N'Владимир', N'Владимирович', 79, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (69, N'Селютина', N'Мария', N'Александровна', 77, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (70, N'Фомин', N'Александр', N'Андреевич', 73, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (71, N'Гукун', N'Яна', N'Евгеньевна', 61, 1)
INSERT [dbo].[Student] ([student_id], [surname], [name], [patronymic], [fakulty_id], [course]) VALUES (72, N'Иванова', N'Елизавета', N'Сергеевна', 65, 1)
SET IDENTITY_INSERT [dbo].[Student] OFF
SET IDENTITY_INSERT [dbo].[University] ON 

INSERT [dbo].[University] ([university_id], [university], [city_id]) VALUES (1, N'ПГНИУ', 1)
INSERT [dbo].[University] ([university_id], [university], [city_id]) VALUES (2, N'ПНИПУ', 1)
INSERT [dbo].[University] ([university_id], [university], [city_id]) VALUES (3, N'ПГГПУ', 1)
INSERT [dbo].[University] ([university_id], [university], [city_id]) VALUES (4, N'ПГМУ им. Вагнера', 1)
INSERT [dbo].[University] ([university_id], [university], [city_id]) VALUES (5, N'ПГСХА', 1)
INSERT [dbo].[University] ([university_id], [university], [city_id]) VALUES (6, N'ВШЭ', 1)
SET IDENTITY_INSERT [dbo].[University] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [DF_University_University]    Script Date: 23.01.2018 13:01:34 ******/
ALTER TABLE [dbo].[University] ADD  CONSTRAINT [DF_University_University] UNIQUE NONCLUSTERED 
(
	[university] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_course]  DEFAULT ((1)) FOR [course]
GO
ALTER TABLE [dbo].[Fakultys]  WITH CHECK ADD  CONSTRAINT [FK_Fakultys_University] FOREIGN KEY([university_id])
REFERENCES [dbo].[University] ([university_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Fakultys] CHECK CONSTRAINT [FK_Fakultys_University]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Fakulty1] FOREIGN KEY([fakulty_id])
REFERENCES [dbo].[Fakultys] ([fakulty_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Fakulty1]
GO
ALTER TABLE [dbo].[University]  WITH CHECK ADD  CONSTRAINT [FK_University_Citys] FOREIGN KEY([city_id])
REFERENCES [dbo].[Citys] ([city_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[University] CHECK CONSTRAINT [FK_University_Citys]
GO
USE [master]
GO
ALTER DATABASE [Universitys] SET  READ_WRITE 
GO
