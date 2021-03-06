USE [master]
GO
/****** Object:  Database [cspublicationcrawler]    Script Date: 08/26/2011 04:28:14 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'cspublicationcrawler')
BEGIN
CREATE DATABASE [cspublicationcrawler] ON  PRIMARY 
( NAME = N'cspublicationcrawler', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\cspublicationcrawler.mdf' , SIZE = 2304KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'cspublicationcrawler_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\cspublicationcrawler_log.LDF' , SIZE = 768KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
END
GO
ALTER DATABASE [cspublicationcrawler] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [cspublicationcrawler].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [cspublicationcrawler] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [cspublicationcrawler] SET ANSI_NULLS OFF
GO
ALTER DATABASE [cspublicationcrawler] SET ANSI_PADDING OFF
GO
ALTER DATABASE [cspublicationcrawler] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [cspublicationcrawler] SET ARITHABORT OFF
GO
ALTER DATABASE [cspublicationcrawler] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [cspublicationcrawler] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [cspublicationcrawler] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [cspublicationcrawler] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [cspublicationcrawler] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [cspublicationcrawler] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [cspublicationcrawler] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [cspublicationcrawler] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [cspublicationcrawler] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [cspublicationcrawler] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [cspublicationcrawler] SET  ENABLE_BROKER
GO
ALTER DATABASE [cspublicationcrawler] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [cspublicationcrawler] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [cspublicationcrawler] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [cspublicationcrawler] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [cspublicationcrawler] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [cspublicationcrawler] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [cspublicationcrawler] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [cspublicationcrawler] SET  READ_WRITE
GO
ALTER DATABASE [cspublicationcrawler] SET RECOVERY FULL
GO
ALTER DATABASE [cspublicationcrawler] SET  MULTI_USER
GO
ALTER DATABASE [cspublicationcrawler] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [cspublicationcrawler] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'cspublicationcrawler', N'ON'
GO
USE [cspublicationcrawler]
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__reviewer__review__19DFD96B]') AND parent_object_id = OBJECT_ID(N'[dbo].[reviewer]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__reviewer__review__19DFD96B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[reviewer] DROP CONSTRAINT [DF__reviewer__review__19DFD96B]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__reviewer__image__1AD3FDA4]') AND parent_object_id = OBJECT_ID(N'[dbo].[reviewer]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__reviewer__image__1AD3FDA4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[reviewer] DROP CONSTRAINT [DF__reviewer__image__1AD3FDA4]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__reviewer__emailA__1BC821DD]') AND parent_object_id = OBJECT_ID(N'[dbo].[reviewer]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__reviewer__emailA__1BC821DD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[reviewer] DROP CONSTRAINT [DF__reviewer__emailA__1BC821DD]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__reviewer__websit__1CBC4616]') AND parent_object_id = OBJECT_ID(N'[dbo].[reviewer]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__reviewer__websit__1CBC4616]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[reviewer] DROP CONSTRAINT [DF__reviewer__websit__1CBC4616]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__reviewer__organi__1DB06A4F]') AND parent_object_id = OBJECT_ID(N'[dbo].[reviewer]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__reviewer__organi__1DB06A4F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[reviewer] DROP CONSTRAINT [DF__reviewer__organi__1DB06A4F]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__pcmember__pcMemb__14270015]') AND parent_object_id = OBJECT_ID(N'[dbo].[pcmember]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pcmember__pcMemb__14270015]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pcmember] DROP CONSTRAINT [DF__pcmember__pcMemb__14270015]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__pcmember__image__151B244E]') AND parent_object_id = OBJECT_ID(N'[dbo].[pcmember]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pcmember__image__151B244E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pcmember] DROP CONSTRAINT [DF__pcmember__image__151B244E]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__pcmember__emailA__160F4887]') AND parent_object_id = OBJECT_ID(N'[dbo].[pcmember]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pcmember__emailA__160F4887]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pcmember] DROP CONSTRAINT [DF__pcmember__emailA__160F4887]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__pcmember__websit__17036CC0]') AND parent_object_id = OBJECT_ID(N'[dbo].[pcmember]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pcmember__websit__17036CC0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pcmember] DROP CONSTRAINT [DF__pcmember__websit__17036CC0]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__pcmember__organi__17F790F9]') AND parent_object_id = OBJECT_ID(N'[dbo].[pcmember]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pcmember__organi__17F790F9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pcmember] DROP CONSTRAINT [DF__pcmember__organi__17F790F9]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_pap__citat__49C3F6B7]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_paper_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_pap__citat__49C3F6B7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_paper_subdomain] DROP CONSTRAINT [DF___rank_pap__citat__49C3F6B7]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_pape__rank__4AB81AF0]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_paper_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_pape__rank__4AB81AF0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_paper_subdomain] DROP CONSTRAINT [DF___rank_pape__rank__4AB81AF0]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_pap__citat__46E78A0C]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_paper_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_pap__citat__46E78A0C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_paper_keyword] DROP CONSTRAINT [DF___rank_pap__citat__46E78A0C]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_pape__rank__47DBAE45]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_paper_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_pape__rank__47DBAE45]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_paper_keyword] DROP CONSTRAINT [DF___rank_pape__rank__47DBAE45]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_pap__citat__440B1D61]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_pap__citat__440B1D61]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_paper] DROP CONSTRAINT [DF___rank_pap__citat__440B1D61]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_pape__rank__44FF419A]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_pape__rank__44FF419A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_paper] DROP CONSTRAINT [DF___rank_pape__rank__44FF419A]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__publi__3F466844]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__publi__3F466844]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_subdomain] DROP CONSTRAINT [DF___rank_org__publi__3F466844]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__citat__403A8C7D]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__citat__403A8C7D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_subdomain] DROP CONSTRAINT [DF___rank_org__citat__403A8C7D]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__citat__412EB0B6]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__citat__412EB0B6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_subdomain] DROP CONSTRAINT [DF___rank_org__citat__412EB0B6]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org___rank__4222D4EF]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org___rank__4222D4EF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_subdomain] DROP CONSTRAINT [DF___rank_org___rank__4222D4EF]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__publi__3A81B327]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__publi__3A81B327]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_keyword] DROP CONSTRAINT [DF___rank_org__publi__3A81B327]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__citat__3B75D760]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__citat__3B75D760]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_keyword] DROP CONSTRAINT [DF___rank_org__citat__3B75D760]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__citat__3C69FB99]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__citat__3C69FB99]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_keyword] DROP CONSTRAINT [DF___rank_org__citat__3C69FB99]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org___rank__3D5E1FD2]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org___rank__3D5E1FD2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_keyword] DROP CONSTRAINT [DF___rank_org___rank__3D5E1FD2]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__publi__36B12243]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__publi__36B12243]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org] DROP CONSTRAINT [DF___rank_org__publi__36B12243]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__citat__37A5467C]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__citat__37A5467C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org] DROP CONSTRAINT [DF___rank_org__citat__37A5467C]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__rank__38996AB5]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__rank__38996AB5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org] DROP CONSTRAINT [DF___rank_org__rank__38996AB5]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__publi__31EC6D26]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__publi__31EC6D26]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_subdomain] DROP CONSTRAINT [DF___rank_mag__publi__31EC6D26]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__citat__32E0915F]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__citat__32E0915F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_subdomain] DROP CONSTRAINT [DF___rank_mag__citat__32E0915F]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__citat__33D4B598]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__citat__33D4B598]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_subdomain] DROP CONSTRAINT [DF___rank_mag__citat__33D4B598]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_maga__rank__34C8D9D1]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_maga__rank__34C8D9D1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_subdomain] DROP CONSTRAINT [DF___rank_maga__rank__34C8D9D1]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__publi__2D27B809]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__publi__2D27B809]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_keyword] DROP CONSTRAINT [DF___rank_mag__publi__2D27B809]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__citat__2E1BDC42]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__citat__2E1BDC42]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_keyword] DROP CONSTRAINT [DF___rank_mag__citat__2E1BDC42]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__citat__2F10007B]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__citat__2F10007B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_keyword] DROP CONSTRAINT [DF___rank_mag__citat__2F10007B]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_maga__rank__300424B4]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_maga__rank__300424B4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_keyword] DROP CONSTRAINT [DF___rank_maga__rank__300424B4]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__publi__29572725]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__publi__29572725]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine] DROP CONSTRAINT [DF___rank_mag__publi__29572725]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__citat__2A4B4B5E]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__citat__2A4B4B5E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine] DROP CONSTRAINT [DF___rank_mag__citat__2A4B4B5E]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_maga__rank__2B3F6F97]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_maga__rank__2B3F6F97]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine] DROP CONSTRAINT [DF___rank_maga__rank__2B3F6F97]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__publi__24927208]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__publi__24927208]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_subdomain] DROP CONSTRAINT [DF___rank_jou__publi__24927208]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__citat__25869641]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__citat__25869641]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_subdomain] DROP CONSTRAINT [DF___rank_jou__citat__25869641]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__citat__267ABA7A]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__citat__267ABA7A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_subdomain] DROP CONSTRAINT [DF___rank_jou__citat__267ABA7A]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jour__rank__276EDEB3]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jour__rank__276EDEB3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_subdomain] DROP CONSTRAINT [DF___rank_jour__rank__276EDEB3]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__publi__1FCDBCEB]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__publi__1FCDBCEB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_keyword] DROP CONSTRAINT [DF___rank_jou__publi__1FCDBCEB]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__citat__20C1E124]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__citat__20C1E124]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_keyword] DROP CONSTRAINT [DF___rank_jou__citat__20C1E124]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__citat__21B6055D]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__citat__21B6055D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_keyword] DROP CONSTRAINT [DF___rank_jou__citat__21B6055D]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jour__rank__22AA2996]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jour__rank__22AA2996]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_keyword] DROP CONSTRAINT [DF___rank_jour__rank__22AA2996]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__publi__1BFD2C07]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__publi__1BFD2C07]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal] DROP CONSTRAINT [DF___rank_jou__publi__1BFD2C07]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__citat__1CF15040]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__citat__1CF15040]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal] DROP CONSTRAINT [DF___rank_jou__citat__1CF15040]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jour__rank__1DE57479]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jour__rank__1DE57479]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal] DROP CONSTRAINT [DF___rank_jour__rank__1DE57479]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__publi__173876EA]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__publi__173876EA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_subdomain] DROP CONSTRAINT [DF___rank_con__publi__173876EA]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__citat__182C9B23]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__citat__182C9B23]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_subdomain] DROP CONSTRAINT [DF___rank_con__citat__182C9B23]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__citat__1920BF5C]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__citat__1920BF5C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_subdomain] DROP CONSTRAINT [DF___rank_con__citat__1920BF5C]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_conf__rank__1A14E395]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_conf__rank__1A14E395]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_subdomain] DROP CONSTRAINT [DF___rank_conf__rank__1A14E395]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__publi__1273C1CD]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__publi__1273C1CD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_keyword] DROP CONSTRAINT [DF___rank_con__publi__1273C1CD]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__citat__1367E606]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__citat__1367E606]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_keyword] DROP CONSTRAINT [DF___rank_con__citat__1367E606]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__citat__145C0A3F]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__citat__145C0A3F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_keyword] DROP CONSTRAINT [DF___rank_con__citat__145C0A3F]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_conf__rank__15502E78]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_conf__rank__15502E78]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_keyword] DROP CONSTRAINT [DF___rank_conf__rank__15502E78]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__publi__0EA330E9]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__publi__0EA330E9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference] DROP CONSTRAINT [DF___rank_con__publi__0EA330E9]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__citat__0F975522]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__citat__0F975522]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference] DROP CONSTRAINT [DF___rank_con__citat__0F975522]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_conf__rank__108B795B]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_conf__rank__108B795B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference] DROP CONSTRAINT [DF___rank_conf__rank__108B795B]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__publi__08EA5793]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__publi__08EA5793]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_subdomain] DROP CONSTRAINT [DF___rank_aut__publi__08EA5793]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__citat__09DE7BCC]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__citat__09DE7BCC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_subdomain] DROP CONSTRAINT [DF___rank_aut__citat__09DE7BCC]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__citat__0AD2A005]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__citat__0AD2A005]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_subdomain] DROP CONSTRAINT [DF___rank_aut__citat__0AD2A005]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_auth__rank__0BC6C43E]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_auth__rank__0BC6C43E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_subdomain] DROP CONSTRAINT [DF___rank_auth__rank__0BC6C43E]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__coAut__0CBAE877]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__coAut__0CBAE877]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_subdomain] DROP CONSTRAINT [DF___rank_aut__coAut__0CBAE877]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__publi__03317E3D]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__publi__03317E3D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_keyword] DROP CONSTRAINT [DF___rank_aut__publi__03317E3D]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__citat__0425A276]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__citat__0425A276]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_keyword] DROP CONSTRAINT [DF___rank_aut__citat__0425A276]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__citat__0519C6AF]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__citat__0519C6AF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_keyword] DROP CONSTRAINT [DF___rank_aut__citat__0519C6AF]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_auth__rank__060DEAE8]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_auth__rank__060DEAE8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_keyword] DROP CONSTRAINT [DF___rank_auth__rank__060DEAE8]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__coAut__07020F21]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__coAut__07020F21]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_keyword] DROP CONSTRAINT [DF___rank_aut__coAut__07020F21]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__publi__7E6CC920]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__publi__7E6CC920]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author] DROP CONSTRAINT [DF___rank_aut__publi__7E6CC920]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__citat__7F60ED59]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__citat__7F60ED59]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author] DROP CONSTRAINT [DF___rank_aut__citat__7F60ED59]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_auth__rank__00551192]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_auth__rank__00551192]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author] DROP CONSTRAINT [DF___rank_auth__rank__00551192]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__coAut__014935CB]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__coAut__014935CB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author] DROP CONSTRAINT [DF___rank_aut__coAut__014935CB]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conferenc__confe__5AEE82B9]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conferenc__confe__5AEE82B9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] DROP CONSTRAINT [DF__conferenc__confe__5AEE82B9]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conferenc__websi__5BE2A6F2]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conferenc__websi__5BE2A6F2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] DROP CONSTRAINT [DF__conferenc__websi__5BE2A6F2]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conferenc__organ__5CD6CB2B]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conferenc__organ__5CD6CB2B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] DROP CONSTRAINT [DF__conferenc__organ__5CD6CB2B]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conferenc__organ__5DCAEF64]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conferenc__organ__5DCAEF64]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] DROP CONSTRAINT [DF__conferenc__organ__5DCAEF64]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conferenc__durat__5EBF139D]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conferenc__durat__5EBF139D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] DROP CONSTRAINT [DF__conferenc__durat__5EBF139D]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conferenc__yearS__5FB337D6]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conferenc__yearS__5FB337D6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] DROP CONSTRAINT [DF__conferenc__yearS__5FB337D6]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conferenc__yearE__60A75C0F]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conferenc__yearE__60A75C0F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] DROP CONSTRAINT [DF__conferenc__yearE__60A75C0F]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conference__url__619B8048]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conference__url__619B8048]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] DROP CONSTRAINT [DF__conference__url__619B8048]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__org__orgName__787EE5A0]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__org__orgName__787EE5A0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[org] DROP CONSTRAINT [DF__org__orgName__787EE5A0]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__org__website__797309D9]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__org__website__797309D9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[org] DROP CONSTRAINT [DF__org__website__797309D9]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__org__continent__7A672E12]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__org__continent__7A672E12]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[org] DROP CONSTRAINT [DF__org__continent__7A672E12]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__org__idOrgParent__7B5B524B]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__org__idOrgParent__7B5B524B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[org] DROP CONSTRAINT [DF__org__idOrgParent__7B5B524B]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__org__h_index__7C4F7684]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__org__h_index__7C4F7684]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[org] DROP CONSTRAINT [DF__org__h_index__7C4F7684]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__org__url__7D439ABD]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__org__url__7D439ABD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[org] DROP CONSTRAINT [DF__org__url__7D439ABD]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__magazine__magazi__71D1E811]') AND parent_object_id = OBJECT_ID(N'[dbo].[magazine]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__magazine__magazi__71D1E811]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[magazine] DROP CONSTRAINT [DF__magazine__magazi__71D1E811]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__magazine__websit__72C60C4A]') AND parent_object_id = OBJECT_ID(N'[dbo].[magazine]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__magazine__websit__72C60C4A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[magazine] DROP CONSTRAINT [DF__magazine__websit__72C60C4A]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__magazine__yearSt__73BA3083]') AND parent_object_id = OBJECT_ID(N'[dbo].[magazine]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__magazine__yearSt__73BA3083]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[magazine] DROP CONSTRAINT [DF__magazine__yearSt__73BA3083]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__magazine__yearEn__74AE54BC]') AND parent_object_id = OBJECT_ID(N'[dbo].[magazine]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__magazine__yearEn__74AE54BC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[magazine] DROP CONSTRAINT [DF__magazine__yearEn__74AE54BC]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__magazine__organi__75A278F5]') AND parent_object_id = OBJECT_ID(N'[dbo].[magazine]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__magazine__organi__75A278F5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[magazine] DROP CONSTRAINT [DF__magazine__organi__75A278F5]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__magazine__url__76969D2E]') AND parent_object_id = OBJECT_ID(N'[dbo].[magazine]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__magazine__url__76969D2E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[magazine] DROP CONSTRAINT [DF__magazine__url__76969D2E]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__keyword__keyword__6E01572D]') AND parent_object_id = OBJECT_ID(N'[dbo].[keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__keyword__keyword__6E01572D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[keyword] DROP CONSTRAINT [DF__keyword__keyword__6E01572D]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__keyword__stemmin__6EF57B66]') AND parent_object_id = OBJECT_ID(N'[dbo].[keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__keyword__stemmin__6EF57B66]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[keyword] DROP CONSTRAINT [DF__keyword__stemmin__6EF57B66]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__keyword__url__6FE99F9F]') AND parent_object_id = OBJECT_ID(N'[dbo].[keyword]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__keyword__url__6FE99F9F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[keyword] DROP CONSTRAINT [DF__keyword__url__6FE99F9F]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__journal__journal__6754599E]') AND parent_object_id = OBJECT_ID(N'[dbo].[journal]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__journal__journal__6754599E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[journal] DROP CONSTRAINT [DF__journal__journal__6754599E]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__journal__website__68487DD7]') AND parent_object_id = OBJECT_ID(N'[dbo].[journal]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__journal__website__68487DD7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[journal] DROP CONSTRAINT [DF__journal__website__68487DD7]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__journal__yearSta__693CA210]') AND parent_object_id = OBJECT_ID(N'[dbo].[journal]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__journal__yearSta__693CA210]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[journal] DROP CONSTRAINT [DF__journal__yearSta__693CA210]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__journal__yearEnd__6A30C649]') AND parent_object_id = OBJECT_ID(N'[dbo].[journal]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__journal__yearEnd__6A30C649]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[journal] DROP CONSTRAINT [DF__journal__yearEnd__6A30C649]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__journal__organiz__6B24EA82]') AND parent_object_id = OBJECT_ID(N'[dbo].[journal]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__journal__organiz__6B24EA82]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[journal] DROP CONSTRAINT [DF__journal__organiz__6B24EA82]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__journal__url__6C190EBB]') AND parent_object_id = OBJECT_ID(N'[dbo].[journal]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__journal__url__6C190EBB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[journal] DROP CONSTRAINT [DF__journal__url__6C190EBB]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__domain__domainNa__656C112C]') AND parent_object_id = OBJECT_ID(N'[dbo].[domain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__domain__domainNa__656C112C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[domain] DROP CONSTRAINT [DF__domain__domainNa__656C112C]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conference__year__6383C8BA]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference_pcmember]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conference__year__6383C8BA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference_pcmember] DROP CONSTRAINT [DF__conference__year__6383C8BA]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__doi__7F2BE32F]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__doi__7F2BE32F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__doi__7F2BE32F]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__isbn__00200768]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__isbn__00200768]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__isbn__00200768]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__url__01142BA1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__url__01142BA1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__url__01142BA1]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__title__02084FDA]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__title__02084FDA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__title__02084FDA]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__abstract__02FC7413]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__abstract__02FC7413]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__abstract__02FC7413]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__volume__03F0984C]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__volume__03F0984C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__volume__03F0984C]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__pages__04E4BC85]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__pages__04E4BC85]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__pages__04E4BC85]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__year__05D8E0BE]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__year__05D8E0BE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__year__05D8E0BE]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__bibTex__06CD04F7]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__bibTex__06CD04F7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__bibTex__06CD04F7]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__endNote__07C12930]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__endNote__07C12930]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__endNote__07C12930]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__idJournal__08B54D69]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__idJournal__08B54D69]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__idJournal__08B54D69]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__idConfere__09A971A2]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__idConfere__09A971A2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__idConfere__09A971A2]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__idMagazin__0A9D95DB]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__idMagazin__0A9D95DB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__idMagazin__0A9D95DB]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__version__0B91BA14]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__version__0B91BA14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__version__0B91BA14]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__paperFile__0C85DE4D]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__paperFile__0C85DE4D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [DF__paper__paperFile__0C85DE4D]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__subdomain__subdo__1F98B2C1]') AND parent_object_id = OBJECT_ID(N'[dbo].[subdomain]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__subdomain__subdo__1F98B2C1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[subdomain] DROP CONSTRAINT [DF__subdomain__subdo__1F98B2C1]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__authorNa__4CA06362]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__authorNa__4CA06362]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] DROP CONSTRAINT [DF__author__authorNa__4CA06362]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__image__4D94879B]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__image__4D94879B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] DROP CONSTRAINT [DF__author__image__4D94879B]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__emailAdd__4E88ABD4]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__emailAdd__4E88ABD4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] DROP CONSTRAINT [DF__author__emailAdd__4E88ABD4]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__website__4F7CD00D]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__website__4F7CD00D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] DROP CONSTRAINT [DF__author__website__4F7CD00D]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__idOrg__5070F446]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__idOrg__5070F446]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] DROP CONSTRAINT [DF__author__idOrg__5070F446]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__h_index__5165187F]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__h_index__5165187F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] DROP CONSTRAINT [DF__author__h_index__5165187F]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__g_index__52593CB8]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__g_index__52593CB8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] DROP CONSTRAINT [DF__author__g_index__52593CB8]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__url__534D60F1]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__url__534D60F1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] DROP CONSTRAINT [DF__author__url__534D60F1]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper_rev__ratin__114A936A]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_reviewer]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper_rev__ratin__114A936A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper_reviewer] DROP CONSTRAINT [DF__paper_rev__ratin__114A936A]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper_rev__conte__123EB7A3]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_reviewer]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper_rev__conte__123EB7A3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper_reviewer] DROP CONSTRAINT [DF__paper_rev__conte__123EB7A3]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper_pap__citat__0F624AF8]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_paper]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper_pap__citat__0F624AF8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper_paper] DROP CONSTRAINT [DF__paper_pap__citat__0F624AF8]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__comment__rating__5812160E]') AND parent_object_id = OBJECT_ID(N'[dbo].[comment]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__comment__rating__5812160E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[comment] DROP CONSTRAINT [DF__comment__rating__5812160E]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__comment__content__59063A47]') AND parent_object_id = OBJECT_ID(N'[dbo].[comment]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__comment__content__59063A47]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[comment] DROP CONSTRAINT [DF__comment__content__59063A47]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__authorins__insta__5629CD9C]') AND parent_object_id = OBJECT_ID(N'[dbo].[authorinstance]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__authorins__insta__5629CD9C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[authorinstance] DROP CONSTRAINT [DF__authorins__insta__5629CD9C]
END


End
GO
/****** Object:  ForeignKey [org$fk_Org_Org1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[org$fk_Org_Org1]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
ALTER TABLE [dbo].[org] DROP CONSTRAINT [org$fk_Org_Org1]
GO
/****** Object:  ForeignKey [conference_pcmember$fk_Conference_has_pcMember_Conference1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[conference_pcmember$fk_Conference_has_pcMember_Conference1]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference_pcmember]'))
ALTER TABLE [dbo].[conference_pcmember] DROP CONSTRAINT [conference_pcmember$fk_Conference_has_pcMember_Conference1]
GO
/****** Object:  ForeignKey [conference_pcmember$fk_Conference_has_pcMember_pcMember1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[conference_pcmember$fk_Conference_has_pcMember_pcMember1]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference_pcmember]'))
ALTER TABLE [dbo].[conference_pcmember] DROP CONSTRAINT [conference_pcmember$fk_Conference_has_pcMember_pcMember1]
GO
/****** Object:  ForeignKey [paper$fk_Paper_Conference1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper$fk_Paper_Conference1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [paper$fk_Paper_Conference1]
GO
/****** Object:  ForeignKey [paper$fk_Paper_Journal1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper$fk_Paper_Journal1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [paper$fk_Paper_Journal1]
GO
/****** Object:  ForeignKey [paper$fk_Paper_Magazine1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper$fk_Paper_Magazine1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
ALTER TABLE [dbo].[paper] DROP CONSTRAINT [paper$fk_Paper_Magazine1]
GO
/****** Object:  ForeignKey [subdomain$fk_Subdomain_Domain1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[subdomain$fk_Subdomain_Domain1]') AND parent_object_id = OBJECT_ID(N'[dbo].[subdomain]'))
ALTER TABLE [dbo].[subdomain] DROP CONSTRAINT [subdomain$fk_Subdomain_Domain1]
GO
/****** Object:  ForeignKey [author$fk_Author_Org]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[author$fk_Author_Org]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
ALTER TABLE [dbo].[author] DROP CONSTRAINT [author$fk_Author_Org]
GO
/****** Object:  ForeignKey [subdomain_paper$fk_Subdomain_has_Paper_Paper1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[subdomain_paper$fk_Subdomain_has_Paper_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[subdomain_paper]'))
ALTER TABLE [dbo].[subdomain_paper] DROP CONSTRAINT [subdomain_paper$fk_Subdomain_has_Paper_Paper1]
GO
/****** Object:  ForeignKey [subdomain_paper$fk_Subdomain_has_Paper_Subdomain1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[subdomain_paper$fk_Subdomain_has_Paper_Subdomain1]') AND parent_object_id = OBJECT_ID(N'[dbo].[subdomain_paper]'))
ALTER TABLE [dbo].[subdomain_paper] DROP CONSTRAINT [subdomain_paper$fk_Subdomain_has_Paper_Subdomain1]
GO
/****** Object:  ForeignKey [paper_reviewer$fk_Paper_has_Reviewer_Paper1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_reviewer$fk_Paper_has_Reviewer_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_reviewer]'))
ALTER TABLE [dbo].[paper_reviewer] DROP CONSTRAINT [paper_reviewer$fk_Paper_has_Reviewer_Paper1]
GO
/****** Object:  ForeignKey [paper_reviewer$fk_Paper_has_Reviewer_Reviewer1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_reviewer$fk_Paper_has_Reviewer_Reviewer1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_reviewer]'))
ALTER TABLE [dbo].[paper_reviewer] DROP CONSTRAINT [paper_reviewer$fk_Paper_has_Reviewer_Reviewer1]
GO
/****** Object:  ForeignKey [paper_paper$fk_Paper_has_Paper_Paper1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_paper$fk_Paper_has_Paper_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_paper]'))
ALTER TABLE [dbo].[paper_paper] DROP CONSTRAINT [paper_paper$fk_Paper_has_Paper_Paper1]
GO
/****** Object:  ForeignKey [paper_paper$fk_Paper_has_Paper_Paper2]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_paper$fk_Paper_has_Paper_Paper2]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_paper]'))
ALTER TABLE [dbo].[paper_paper] DROP CONSTRAINT [paper_paper$fk_Paper_has_Paper_Paper2]
GO
/****** Object:  ForeignKey [paper_keyword$fk_Paper_has_Keyword_Keyword1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_keyword$fk_Paper_has_Keyword_Keyword1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_keyword]'))
ALTER TABLE [dbo].[paper_keyword] DROP CONSTRAINT [paper_keyword$fk_Paper_has_Keyword_Keyword1]
GO
/****** Object:  ForeignKey [paper_keyword$fk_Paper_has_Keyword_Paper1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_keyword$fk_Paper_has_Keyword_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_keyword]'))
ALTER TABLE [dbo].[paper_keyword] DROP CONSTRAINT [paper_keyword$fk_Paper_has_Keyword_Paper1]
GO
/****** Object:  ForeignKey [comment$fk_Comment_Paper1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[comment$fk_Comment_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[comment]'))
ALTER TABLE [dbo].[comment] DROP CONSTRAINT [comment$fk_Comment_Paper1]
GO
/****** Object:  ForeignKey [authorinstance$fk_authorInstance_Author1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[authorinstance$fk_authorInstance_Author1]') AND parent_object_id = OBJECT_ID(N'[dbo].[authorinstance]'))
ALTER TABLE [dbo].[authorinstance] DROP CONSTRAINT [authorinstance$fk_authorInstance_Author1]
GO
/****** Object:  ForeignKey [author_paper$fk_Author_has_Paper_Author1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[author_paper$fk_Author_has_Paper_Author1]') AND parent_object_id = OBJECT_ID(N'[dbo].[author_paper]'))
ALTER TABLE [dbo].[author_paper] DROP CONSTRAINT [author_paper$fk_Author_has_Paper_Author1]
GO
/****** Object:  ForeignKey [author_paper$fk_Author_has_Paper_Paper1]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[author_paper$fk_Author_has_Paper_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[author_paper]'))
ALTER TABLE [dbo].[author_paper] DROP CONSTRAINT [author_paper$fk_Author_has_Paper_Paper1]
GO
/****** Object:  Table [dbo].[author_paper]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[author_paper]') AND type in (N'U'))
DROP TABLE [dbo].[author_paper]
GO
/****** Object:  Table [dbo].[authorinstance]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[authorinstance]') AND type in (N'U'))
DROP TABLE [dbo].[authorinstance]
GO
/****** Object:  Table [dbo].[comment]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[comment]') AND type in (N'U'))
DROP TABLE [dbo].[comment]
GO
/****** Object:  Table [dbo].[paper_keyword]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[paper_keyword]') AND type in (N'U'))
DROP TABLE [dbo].[paper_keyword]
GO
/****** Object:  Table [dbo].[paper_paper]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[paper_paper]') AND type in (N'U'))
DROP TABLE [dbo].[paper_paper]
GO
/****** Object:  Table [dbo].[paper_reviewer]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[paper_reviewer]') AND type in (N'U'))
DROP TABLE [dbo].[paper_reviewer]
GO
/****** Object:  Table [dbo].[subdomain_paper]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[subdomain_paper]') AND type in (N'U'))
DROP TABLE [dbo].[subdomain_paper]
GO
/****** Object:  Table [dbo].[author]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[author]') AND type in (N'U'))
DROP TABLE [dbo].[author]
GO
/****** Object:  Table [dbo].[subdomain]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[subdomain]') AND type in (N'U'))
DROP TABLE [dbo].[subdomain]
GO
/****** Object:  Table [dbo].[paper]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[paper]') AND type in (N'U'))
DROP TABLE [dbo].[paper]
GO
/****** Object:  Table [dbo].[conference_pcmember]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[conference_pcmember]') AND type in (N'U'))
DROP TABLE [dbo].[conference_pcmember]
GO
/****** Object:  Table [dbo].[domain]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[domain]') AND type in (N'U'))
DROP TABLE [dbo].[domain]
GO
/****** Object:  Table [dbo].[journal]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[journal]') AND type in (N'U'))
DROP TABLE [dbo].[journal]
GO
/****** Object:  Table [dbo].[keyword]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[keyword]') AND type in (N'U'))
DROP TABLE [dbo].[keyword]
GO
/****** Object:  Table [dbo].[magazine]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[magazine]') AND type in (N'U'))
DROP TABLE [dbo].[magazine]
GO
/****** Object:  Table [dbo].[org]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[org]') AND type in (N'U'))
DROP TABLE [dbo].[org]
GO
/****** Object:  Table [dbo].[conference]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[conference]') AND type in (N'U'))
DROP TABLE [dbo].[conference]
GO
/****** Object:  Table [dbo].[_rank_author]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_author]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_author]
GO
/****** Object:  Table [dbo].[_rank_author_keyword]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_author_keyword]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_author_keyword]
GO
/****** Object:  Table [dbo].[_rank_author_subdomain]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_author_subdomain]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_author_subdomain]
GO
/****** Object:  Table [dbo].[_rank_conference]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_conference]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_conference]
GO
/****** Object:  Table [dbo].[_rank_conference_keyword]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_conference_keyword]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_conference_keyword]
GO
/****** Object:  Table [dbo].[_rank_conference_subdomain]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_conference_subdomain]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_conference_subdomain]
GO
/****** Object:  Table [dbo].[_rank_journal]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_journal]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_journal]
GO
/****** Object:  Table [dbo].[_rank_journal_keyword]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_journal_keyword]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_journal_keyword]
GO
/****** Object:  Table [dbo].[_rank_journal_subdomain]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_journal_subdomain]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_journal_subdomain]
GO
/****** Object:  Table [dbo].[_rank_magazine]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_magazine]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_magazine]
GO
/****** Object:  Table [dbo].[_rank_magazine_keyword]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_magazine_keyword]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_magazine_keyword]
GO
/****** Object:  Table [dbo].[_rank_magazine_subdomain]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_magazine_subdomain]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_magazine_subdomain]
GO
/****** Object:  Table [dbo].[_rank_org]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_org]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_org]
GO
/****** Object:  Table [dbo].[_rank_org_keyword]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_org_keyword]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_org_keyword]
GO
/****** Object:  Table [dbo].[_rank_org_subdomain]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_org_subdomain]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_org_subdomain]
GO
/****** Object:  Table [dbo].[_rank_paper]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_paper]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_paper]
GO
/****** Object:  Table [dbo].[_rank_paper_keyword]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_paper_keyword]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_paper_keyword]
GO
/****** Object:  Table [dbo].[_rank_paper_subdomain]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_paper_subdomain]') AND type in (N'U'))
DROP TABLE [dbo].[_rank_paper_subdomain]
GO
/****** Object:  Table [dbo].[pcmember]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pcmember]') AND type in (N'U'))
DROP TABLE [dbo].[pcmember]
GO
/****** Object:  Table [dbo].[reviewer]    Script Date: 08/26/2011 04:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[reviewer]') AND type in (N'U'))
DROP TABLE [dbo].[reviewer]
GO
/****** Object:  Schema [m2ss]    Script Date: 08/26/2011 04:28:14 ******/
IF  EXISTS (SELECT * FROM sys.schemas WHERE name = N'm2ss')
DROP SCHEMA [m2ss]
GO
/****** Object:  Schema [m2ss]    Script Date: 08/26/2011 04:28:14 ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'm2ss')
EXEC sys.sp_executesql N'CREATE SCHEMA [m2ss] AUTHORIZATION [dbo]'
GO
/****** Object:  Table [dbo].[reviewer]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[reviewer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[reviewer](
	[idReviewer] [bigint] IDENTITY(1,1) NOT NULL,
	[reviewerName] [nvarchar](1000) NULL,
	[image] [nvarchar](1000) NULL,
	[emailAddress] [nvarchar](1000) NULL,
	[website] [nvarchar](1000) NULL,
	[organization] [nvarchar](1000) NULL,
 CONSTRAINT [PK_reviewer_idReviewer] PRIMARY KEY CLUSTERED 
(
	[idReviewer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'reviewer', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.reviewer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reviewer'
GO
/****** Object:  Table [dbo].[pcmember]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pcmember]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pcmember](
	[idPCMember] [bigint] IDENTITY(1,1) NOT NULL,
	[pcMemberName] [nvarchar](1000) NULL,
	[image] [nvarchar](1000) NULL,
	[emailAddress] [nvarchar](1000) NULL,
	[website] [nvarchar](1000) NULL,
	[organization] [nvarchar](1000) NULL,
 CONSTRAINT [PK_pcmember_idPCMember] PRIMARY KEY CLUSTERED 
(
	[idPCMember] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'pcmember', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.pcmember' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pcmember'
GO
/****** Object:  Table [dbo].[_rank_paper_subdomain]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_paper_subdomain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_paper_subdomain](
	[idPaper] [int] NOT NULL,
	[idSubdomain] [int] NOT NULL,
	[citationCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_paper_subdomain_idPaper] PRIMARY KEY CLUSTERED 
(
	[idPaper] ASC,
	[idSubdomain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_paper_subdomain', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_paper_subdomain' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_paper_subdomain'
GO
/****** Object:  Table [dbo].[_rank_paper_keyword]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_paper_keyword]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_paper_keyword](
	[idPaper] [int] NOT NULL,
	[idKeyword] [int] NOT NULL,
	[citationCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_paper_keyword_idPaper] PRIMARY KEY CLUSTERED 
(
	[idPaper] ASC,
	[idKeyword] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_paper_keyword', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_paper_keyword' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_paper_keyword'
GO
/****** Object:  Table [dbo].[_rank_paper]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_paper]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_paper](
	[idPaper] [int] NOT NULL,
	[citationCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_paper_idPaper] PRIMARY KEY CLUSTERED 
(
	[idPaper] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_paper', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_paper' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_paper'
GO
/****** Object:  Table [dbo].[_rank_org_subdomain]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_org_subdomain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_org_subdomain](
	[idOrg] [int] NOT NULL,
	[idSubdomain] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[citationInSubdomainCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_org_subdomain_idOrg] PRIMARY KEY CLUSTERED 
(
	[idOrg] ASC,
	[idSubdomain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_org_subdomain', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_org_subdomain' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_org_subdomain'
GO
/****** Object:  Table [dbo].[_rank_org_keyword]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_org_keyword]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_org_keyword](
	[idOrg] [int] NOT NULL,
	[idKeyword] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[citationInKeywordCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_org_keyword_idOrg] PRIMARY KEY CLUSTERED 
(
	[idOrg] ASC,
	[idKeyword] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_org_keyword', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_org_keyword' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_org_keyword'
GO
/****** Object:  Table [dbo].[_rank_org]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_org]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_org](
	[idOrg] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_org_idOrg] PRIMARY KEY CLUSTERED 
(
	[idOrg] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_org', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_org' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_org'
GO
/****** Object:  Table [dbo].[_rank_magazine_subdomain]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_magazine_subdomain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_magazine_subdomain](
	[idMagazine] [int] NOT NULL,
	[idSubdomain] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[citationInSubdomainCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_magazine_subdomain_idMagazine] PRIMARY KEY CLUSTERED 
(
	[idMagazine] ASC,
	[idSubdomain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_magazine_subdomain', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_magazine_subdomain' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_magazine_subdomain'
GO
/****** Object:  Table [dbo].[_rank_magazine_keyword]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_magazine_keyword]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_magazine_keyword](
	[idMagazine] [int] NOT NULL,
	[idKeyword] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[citationInKeywordCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_magazine_keyword_idMagazine] PRIMARY KEY CLUSTERED 
(
	[idMagazine] ASC,
	[idKeyword] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_magazine_keyword', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_magazine_keyword' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_magazine_keyword'
GO
/****** Object:  Table [dbo].[_rank_magazine]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_magazine]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_magazine](
	[idMagazine] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_magazine_idMagazine] PRIMARY KEY CLUSTERED 
(
	[idMagazine] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_magazine', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_magazine' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_magazine'
GO
/****** Object:  Table [dbo].[_rank_journal_subdomain]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_journal_subdomain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_journal_subdomain](
	[idJournal] [int] NOT NULL,
	[idSubdomain] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[citationInSubdomainCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_journal_subdomain_idJournal] PRIMARY KEY CLUSTERED 
(
	[idJournal] ASC,
	[idSubdomain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_journal_subdomain', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_journal_subdomain' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_journal_subdomain'
GO
/****** Object:  Table [dbo].[_rank_journal_keyword]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_journal_keyword]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_journal_keyword](
	[idJournal] [int] NOT NULL,
	[idKeyword] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[citationInKeywordCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_journal_keyword_idJournal] PRIMARY KEY CLUSTERED 
(
	[idJournal] ASC,
	[idKeyword] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_journal_keyword', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_journal_keyword' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_journal_keyword'
GO
/****** Object:  Table [dbo].[_rank_journal]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_journal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_journal](
	[idJournal] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_journal_idJournal] PRIMARY KEY CLUSTERED 
(
	[idJournal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_journal', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_journal' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_journal'
GO
/****** Object:  Table [dbo].[_rank_conference_subdomain]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_conference_subdomain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_conference_subdomain](
	[idConference] [int] NOT NULL,
	[idSubdomain] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[citationInSubdomainCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_conference_subdomain_idConference] PRIMARY KEY CLUSTERED 
(
	[idConference] ASC,
	[idSubdomain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_conference_subdomain', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_conference_subdomain' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_conference_subdomain'
GO
/****** Object:  Table [dbo].[_rank_conference_keyword]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_conference_keyword]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_conference_keyword](
	[idConference] [int] NOT NULL,
	[idKeyword] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[citationInKeywordCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_conference_keyword_idConference] PRIMARY KEY CLUSTERED 
(
	[idConference] ASC,
	[idKeyword] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_conference_keyword', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_conference_keyword' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_conference_keyword'
GO
/****** Object:  Table [dbo].[_rank_conference]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_conference]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_conference](
	[idConference] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[rank] [int] NULL,
 CONSTRAINT [PK__rank_conference_idConference] PRIMARY KEY CLUSTERED 
(
	[idConference] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_conference', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_conference' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_conference'
GO
/****** Object:  Table [dbo].[_rank_author_subdomain]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_author_subdomain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_author_subdomain](
	[idAuthor] [int] NOT NULL,
	[idSubdomain] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[citationInSubdomainCount] [int] NULL,
	[rank] [int] NULL,
	[coAuthorCount] [int] NULL,
 CONSTRAINT [PK__rank_author_subdomain_idAuthor] PRIMARY KEY CLUSTERED 
(
	[idAuthor] ASC,
	[idSubdomain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_author_subdomain', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_author_subdomain' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_author_subdomain'
GO
/****** Object:  Table [dbo].[_rank_author_keyword]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_author_keyword]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_author_keyword](
	[idAuthor] [int] NOT NULL,
	[idKeyword] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[citationInKeywordCount] [int] NULL,
	[rank] [int] NULL,
	[coAuthorCount] [int] NULL,
 CONSTRAINT [PK__rank_author_keyword_idAuthor] PRIMARY KEY CLUSTERED 
(
	[idAuthor] ASC,
	[idKeyword] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_author_keyword', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_author_keyword' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_author_keyword'
GO
/****** Object:  Table [dbo].[_rank_author]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rank_author]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[_rank_author](
	[idAuthor] [int] NOT NULL,
	[publicationCount] [int] NULL,
	[citationCount] [int] NULL,
	[rank] [int] NULL,
	[coAuthorCount] [int] NULL,
 CONSTRAINT [PK__rank_author_idAuthor] PRIMARY KEY CLUSTERED 
(
	[idAuthor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'_rank_author', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler._rank_author' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'_rank_author'
GO
/****** Object:  Table [dbo].[conference]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[conference]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[conference](
	[idConference] [bigint] IDENTITY(1,1) NOT NULL,
	[conferenceName] [nvarchar](1000) NULL,
	[website] [nvarchar](1000) NULL,
	[organization] [nvarchar](1000) NULL,
	[organizedLocation] [nvarchar](1000) NULL,
	[duration] [nvarchar](1000) NULL,
	[yearStart] [bigint] NULL,
	[yearEnd] [bigint] NULL,
	[url] [nvarchar](1000) NULL,
 CONSTRAINT [PK_conference_idConference] PRIMARY KEY CLUSTERED 
(
	[idConference] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'conference', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.conference' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'conference'
GO
/****** Object:  Table [dbo].[org]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[org]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[org](
	[idOrg] [bigint] IDENTITY(1,1) NOT NULL,
	[orgName] [nvarchar](1000) NULL,
	[website] [nvarchar](1000) NULL,
	[continent] [nvarchar](1000) NULL,
	[idOrgParent] [bigint] NULL,
	[h_index] [int] NULL,
	[url] [nvarchar](1000) NULL,
 CONSTRAINT [PK_org_idOrg] PRIMARY KEY CLUSTERED 
(
	[idOrg] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[org]') AND name = N'fk_Org_Org1')
CREATE NONCLUSTERED INDEX [fk_Org_Org1] ON [dbo].[org] 
(
	[idOrgParent] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'org', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.org' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'org'
GO
/****** Object:  Table [dbo].[magazine]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[magazine]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[magazine](
	[idMagazine] [bigint] IDENTITY(1,1) NOT NULL,
	[magazineName] [nvarchar](1000) NULL,
	[website] [nvarchar](1000) NULL,
	[yearStart] [bigint] NULL,
	[yearEnd] [bigint] NULL,
	[organization] [nvarchar](1000) NULL,
	[url] [nvarchar](1000) NULL,
 CONSTRAINT [PK_magazine_idMagazine] PRIMARY KEY CLUSTERED 
(
	[idMagazine] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'magazine', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.magazine' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'magazine'
GO
/****** Object:  Table [dbo].[keyword]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[keyword]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[keyword](
	[idKeyword] [bigint] IDENTITY(1,1) NOT NULL,
	[keyword] [nvarchar](1000) NULL,
	[stemmingVariations] [nvarchar](max) NULL,
	[url] [nvarchar](1000) NULL,
 CONSTRAINT [PK_keyword_idKeyword] PRIMARY KEY CLUSTERED 
(
	[idKeyword] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'keyword', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.keyword' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'keyword'
GO
/****** Object:  Table [dbo].[journal]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[journal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[journal](
	[idJournal] [bigint] IDENTITY(1,1) NOT NULL,
	[journalName] [nvarchar](1000) NULL,
	[website] [nvarchar](1000) NULL,
	[yearStart] [bigint] NULL,
	[yearEnd] [bigint] NULL,
	[organization] [nvarchar](1000) NULL,
	[url] [nvarchar](1000) NULL,
 CONSTRAINT [PK_journal_idJournal] PRIMARY KEY CLUSTERED 
(
	[idJournal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'journal', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.journal' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'journal'
GO
/****** Object:  Table [dbo].[domain]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[domain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[domain](
	[idDomain] [bigint] IDENTITY(3,1) NOT NULL,
	[domainName] [nvarchar](1000) NULL,
 CONSTRAINT [PK_domain_idDomain] PRIMARY KEY CLUSTERED 
(
	[idDomain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'domain', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.domain' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'domain'
GO
SET IDENTITY_INSERT [dbo].[domain] ON
INSERT [dbo].[domain] ([idDomain], [domainName]) VALUES (2, N'Computer Science')
SET IDENTITY_INSERT [dbo].[domain] OFF
/****** Object:  Table [dbo].[conference_pcmember]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[conference_pcmember]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[conference_pcmember](
	[idConference] [bigint] NOT NULL,
	[idPCMember] [bigint] NOT NULL,
	[year] [bigint] NULL,
 CONSTRAINT [PK_conference_pcmember_idConference] PRIMARY KEY CLUSTERED 
(
	[idConference] ASC,
	[idPCMember] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[conference_pcmember]') AND name = N'fk_Conference_has_pcMember_Conference1')
CREATE NONCLUSTERED INDEX [fk_Conference_has_pcMember_Conference1] ON [dbo].[conference_pcmember] 
(
	[idConference] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[conference_pcmember]') AND name = N'fk_Conference_has_pcMember_pcMember1')
CREATE NONCLUSTERED INDEX [fk_Conference_has_pcMember_pcMember1] ON [dbo].[conference_pcmember] 
(
	[idPCMember] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'conference_pcmember', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.conference_pcmember' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'conference_pcmember'
GO
/****** Object:  Table [dbo].[paper]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[paper]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[paper](
	[idPaper] [bigint] IDENTITY(1,1) NOT NULL,
	[doi] [nvarchar](100) NULL,
	[isbn] [nvarchar](100) NULL,
	[url] [nvarchar](1000) NULL,
	[title] [nvarchar](1000) NULL,
	[abstract] [nvarchar](max) NULL,
	[volume] [nvarchar](100) NULL,
	[pages] [nvarchar](100) NULL,
	[year] [bigint] NULL,
	[viewPublication] [nvarchar](max) NULL,
	[bibTex] [nvarchar](1000) NULL,
	[endNote] [nvarchar](1000) NULL,
	[idJournal] [bigint] NULL,
	[idConference] [bigint] NULL,
	[idMagazine] [bigint] NULL,
	[version] [int] NULL,
	[paperFile] [nvarchar](1000) NULL,
 CONSTRAINT [PK_paper_idPaper] PRIMARY KEY CLUSTERED 
(
	[idPaper] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[paper]') AND name = N'fk_Paper_Conference1')
CREATE NONCLUSTERED INDEX [fk_Paper_Conference1] ON [dbo].[paper] 
(
	[idConference] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[paper]') AND name = N'fk_Paper_Journal1')
CREATE NONCLUSTERED INDEX [fk_Paper_Journal1] ON [dbo].[paper] 
(
	[idJournal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[paper]') AND name = N'fk_Paper_Magazine1')
CREATE NONCLUSTERED INDEX [fk_Paper_Magazine1] ON [dbo].[paper] 
(
	[idMagazine] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'paper', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.paper' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'paper'
GO
/****** Object:  Table [dbo].[subdomain]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[subdomain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[subdomain](
	[idSubdomain] [bigint] IDENTITY(25,1) NOT NULL,
	[subdomainName] [nvarchar](1000) NULL,
	[idDomain] [bigint] NOT NULL,
 CONSTRAINT [PK_subdomain_idSubdomain] PRIMARY KEY CLUSTERED 
(
	[idSubdomain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[subdomain]') AND name = N'fk_Subdomain_Domain1')
CREATE NONCLUSTERED INDEX [fk_Subdomain_Domain1] ON [dbo].[subdomain] 
(
	[idDomain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'subdomain', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.subdomain' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subdomain'
GO
SET IDENTITY_INSERT [dbo].[subdomain] ON
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (1, N'Algorithms & Theory', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (2, N'Security & Privacy', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (3, N'Hardware & Architecture', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (4, N'Software Engineering', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (5, N'Artificial Intelligence', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (6, N'Machine Learning & Pattern Recognition', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (7, N'Data Mining', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (8, N'Information Retrieval', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (9, N'Natural Language & Speech', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (10, N'Graphics', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (11, N'Computer Vision', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (12, N'Human-Computer Interaction', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (13, N'Multimedia', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (14, N'Networks & Communications', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (15, N'World Wide Web', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (16, N'Distributed & Parallel Computing', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (17, N'Operating Systems', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (18, N'Databases', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (19, N'Real-Time & Embedded Systems', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (20, N'Simulation', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (21, N'Bioinformatics & Computational Biology', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (22, N'Scientific Computing', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (23, N'Computer Education', 2)
INSERT [dbo].[subdomain] ([idSubdomain], [subdomainName], [idDomain]) VALUES (24, N'Programming Languages', 2)
SET IDENTITY_INSERT [dbo].[subdomain] OFF
/****** Object:  Table [dbo].[author]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[author]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[author](
	[idAuthor] [bigint] IDENTITY(1,1) NOT NULL,
	[authorName] [nvarchar](1000) NULL,
	[image] [nvarchar](1000) NULL,
	[emailAddress] [nvarchar](1000) NULL,
	[website] [nvarchar](1000) NULL,
	[idOrg] [bigint] NULL,
	[h_index] [int] NULL,
	[g_index] [int] NULL,
	[url] [nvarchar](1000) NULL,
 CONSTRAINT [PK_author_idAuthor] PRIMARY KEY CLUSTERED 
(
	[idAuthor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[author]') AND name = N'fk_Author_Org')
CREATE NONCLUSTERED INDEX [fk_Author_Org] ON [dbo].[author] 
(
	[idOrg] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'author', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.author' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'author'
GO
/****** Object:  Table [dbo].[subdomain_paper]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[subdomain_paper]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[subdomain_paper](
	[idPaper] [bigint] NOT NULL,
	[idSubdomain] [bigint] NOT NULL,
 CONSTRAINT [PK_subdomain_paper_idPaper] PRIMARY KEY CLUSTERED 
(
	[idPaper] ASC,
	[idSubdomain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[subdomain_paper]') AND name = N'fk_Subdomain_has_Paper_Paper1')
CREATE NONCLUSTERED INDEX [fk_Subdomain_has_Paper_Paper1] ON [dbo].[subdomain_paper] 
(
	[idPaper] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[subdomain_paper]') AND name = N'fk_Subdomain_has_Paper_Subdomain1')
CREATE NONCLUSTERED INDEX [fk_Subdomain_has_Paper_Subdomain1] ON [dbo].[subdomain_paper] 
(
	[idSubdomain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'subdomain_paper', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.subdomain_paper' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subdomain_paper'
GO
/****** Object:  Table [dbo].[paper_reviewer]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[paper_reviewer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[paper_reviewer](
	[idPaper] [bigint] NOT NULL,
	[idReviewer] [bigint] NOT NULL,
	[rating] [int] NULL,
	[content] [nvarchar](max) NULL,
 CONSTRAINT [PK_paper_reviewer_idPaper] PRIMARY KEY CLUSTERED 
(
	[idPaper] ASC,
	[idReviewer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[paper_reviewer]') AND name = N'fk_Paper_has_Reviewer_Paper1')
CREATE NONCLUSTERED INDEX [fk_Paper_has_Reviewer_Paper1] ON [dbo].[paper_reviewer] 
(
	[idPaper] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[paper_reviewer]') AND name = N'fk_Paper_has_Reviewer_Reviewer1')
CREATE NONCLUSTERED INDEX [fk_Paper_has_Reviewer_Reviewer1] ON [dbo].[paper_reviewer] 
(
	[idReviewer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'paper_reviewer', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.paper_reviewer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'paper_reviewer'
GO
/****** Object:  Table [dbo].[paper_paper]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[paper_paper]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[paper_paper](
	[idPaper] [bigint] NOT NULL,
	[idPaperRef] [bigint] NOT NULL,
	[citationContext] [nvarchar](max) NULL,
 CONSTRAINT [PK_paper_paper_idPaper] PRIMARY KEY CLUSTERED 
(
	[idPaper] ASC,
	[idPaperRef] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[paper_paper]') AND name = N'fk_Paper_has_Paper_Paper1')
CREATE NONCLUSTERED INDEX [fk_Paper_has_Paper_Paper1] ON [dbo].[paper_paper] 
(
	[idPaper] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[paper_paper]') AND name = N'fk_Paper_has_Paper_Paper2')
CREATE NONCLUSTERED INDEX [fk_Paper_has_Paper_Paper2] ON [dbo].[paper_paper] 
(
	[idPaperRef] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'paper_paper', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.paper_paper' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'paper_paper'
GO
/****** Object:  Table [dbo].[paper_keyword]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[paper_keyword]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[paper_keyword](
	[idPaper] [bigint] NOT NULL,
	[idKeyword] [bigint] NOT NULL,
 CONSTRAINT [PK_paper_keyword_idPaper] PRIMARY KEY CLUSTERED 
(
	[idPaper] ASC,
	[idKeyword] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[paper_keyword]') AND name = N'fk_Paper_has_Keyword_Keyword1')
CREATE NONCLUSTERED INDEX [fk_Paper_has_Keyword_Keyword1] ON [dbo].[paper_keyword] 
(
	[idKeyword] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[paper_keyword]') AND name = N'fk_Paper_has_Keyword_Paper1')
CREATE NONCLUSTERED INDEX [fk_Paper_has_Keyword_Paper1] ON [dbo].[paper_keyword] 
(
	[idPaper] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'paper_keyword', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.paper_keyword' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'paper_keyword'
GO
/****** Object:  Table [dbo].[comment]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[comment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[comment](
	[idComment] [bigint] IDENTITY(1,1) NOT NULL,
	[rating] [int] NULL,
	[content] [nvarchar](max) NULL,
	[idPaper] [bigint] NOT NULL,
 CONSTRAINT [PK_comment_idComment] PRIMARY KEY CLUSTERED 
(
	[idComment] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[comment]') AND name = N'fk_Comment_Paper1')
CREATE NONCLUSTERED INDEX [fk_Comment_Paper1] ON [dbo].[comment] 
(
	[idPaper] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'comment', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.comment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'comment'
GO
/****** Object:  Table [dbo].[authorinstance]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[authorinstance]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[authorinstance](
	[autoID] [bigint] IDENTITY(1,1) NOT NULL,
	[instanceName] [nvarchar](1000) NULL,
	[idAuthor] [bigint] NOT NULL,
 CONSTRAINT [PK_authorinstance_autoID] PRIMARY KEY CLUSTERED 
(
	[autoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[authorinstance]') AND name = N'fk_authorInstance_Author1')
CREATE NONCLUSTERED INDEX [fk_authorInstance_Author1] ON [dbo].[authorinstance] 
(
	[idAuthor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'authorinstance', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.authorinstance' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'authorinstance'
GO
/****** Object:  Table [dbo].[author_paper]    Script Date: 08/26/2011 04:28:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[author_paper]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[author_paper](
	[idAuthor] [bigint] NOT NULL,
	[idPaper] [bigint] NOT NULL,
 CONSTRAINT [PK_author_paper_idAuthor] PRIMARY KEY CLUSTERED 
(
	[idAuthor] ASC,
	[idPaper] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[author_paper]') AND name = N'fk_Author_has_Paper_Author1')
CREATE NONCLUSTERED INDEX [fk_Author_has_Paper_Author1] ON [dbo].[author_paper] 
(
	[idAuthor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[author_paper]') AND name = N'fk_Author_has_Paper_Paper1')
CREATE NONCLUSTERED INDEX [fk_Author_has_Paper_Paper1] ON [dbo].[author_paper] 
(
	[idPaper] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_SSMA_SOURCE' , N'SCHEMA',N'dbo', N'TABLE',N'author_paper', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'cspublicationcrawler.author_paper' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'author_paper'
GO
/****** Object:  Default [DF__reviewer__review__19DFD96B]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__reviewer__review__19DFD96B]') AND parent_object_id = OBJECT_ID(N'[dbo].[reviewer]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__reviewer__review__19DFD96B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[reviewer] ADD  DEFAULT (NULL) FOR [reviewerName]
END


End
GO
/****** Object:  Default [DF__reviewer__image__1AD3FDA4]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__reviewer__image__1AD3FDA4]') AND parent_object_id = OBJECT_ID(N'[dbo].[reviewer]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__reviewer__image__1AD3FDA4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[reviewer] ADD  DEFAULT (NULL) FOR [image]
END


End
GO
/****** Object:  Default [DF__reviewer__emailA__1BC821DD]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__reviewer__emailA__1BC821DD]') AND parent_object_id = OBJECT_ID(N'[dbo].[reviewer]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__reviewer__emailA__1BC821DD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[reviewer] ADD  DEFAULT (NULL) FOR [emailAddress]
END


End
GO
/****** Object:  Default [DF__reviewer__websit__1CBC4616]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__reviewer__websit__1CBC4616]') AND parent_object_id = OBJECT_ID(N'[dbo].[reviewer]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__reviewer__websit__1CBC4616]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[reviewer] ADD  DEFAULT (NULL) FOR [website]
END


End
GO
/****** Object:  Default [DF__reviewer__organi__1DB06A4F]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__reviewer__organi__1DB06A4F]') AND parent_object_id = OBJECT_ID(N'[dbo].[reviewer]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__reviewer__organi__1DB06A4F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[reviewer] ADD  DEFAULT (NULL) FOR [organization]
END


End
GO
/****** Object:  Default [DF__pcmember__pcMemb__14270015]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__pcmember__pcMemb__14270015]') AND parent_object_id = OBJECT_ID(N'[dbo].[pcmember]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pcmember__pcMemb__14270015]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pcmember] ADD  DEFAULT (NULL) FOR [pcMemberName]
END


End
GO
/****** Object:  Default [DF__pcmember__image__151B244E]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__pcmember__image__151B244E]') AND parent_object_id = OBJECT_ID(N'[dbo].[pcmember]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pcmember__image__151B244E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pcmember] ADD  DEFAULT (NULL) FOR [image]
END


End
GO
/****** Object:  Default [DF__pcmember__emailA__160F4887]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__pcmember__emailA__160F4887]') AND parent_object_id = OBJECT_ID(N'[dbo].[pcmember]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pcmember__emailA__160F4887]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pcmember] ADD  DEFAULT (NULL) FOR [emailAddress]
END


End
GO
/****** Object:  Default [DF__pcmember__websit__17036CC0]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__pcmember__websit__17036CC0]') AND parent_object_id = OBJECT_ID(N'[dbo].[pcmember]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pcmember__websit__17036CC0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pcmember] ADD  DEFAULT (NULL) FOR [website]
END


End
GO
/****** Object:  Default [DF__pcmember__organi__17F790F9]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__pcmember__organi__17F790F9]') AND parent_object_id = OBJECT_ID(N'[dbo].[pcmember]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pcmember__organi__17F790F9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pcmember] ADD  DEFAULT (NULL) FOR [organization]
END


End
GO
/****** Object:  Default [DF___rank_pap__citat__49C3F6B7]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_pap__citat__49C3F6B7]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_paper_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_pap__citat__49C3F6B7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_paper_subdomain] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_pape__rank__4AB81AF0]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_pape__rank__4AB81AF0]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_paper_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_pape__rank__4AB81AF0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_paper_subdomain] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_pap__citat__46E78A0C]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_pap__citat__46E78A0C]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_paper_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_pap__citat__46E78A0C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_paper_keyword] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_pape__rank__47DBAE45]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_pape__rank__47DBAE45]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_paper_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_pape__rank__47DBAE45]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_paper_keyword] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_pap__citat__440B1D61]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_pap__citat__440B1D61]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_pap__citat__440B1D61]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_paper] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_pape__rank__44FF419A]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_pape__rank__44FF419A]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_pape__rank__44FF419A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_paper] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_org__publi__3F466844]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__publi__3F466844]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__publi__3F466844]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_subdomain] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_org__citat__403A8C7D]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__citat__403A8C7D]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__citat__403A8C7D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_subdomain] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_org__citat__412EB0B6]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__citat__412EB0B6]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__citat__412EB0B6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_subdomain] ADD  DEFAULT (NULL) FOR [citationInSubdomainCount]
END


End
GO
/****** Object:  Default [DF___rank_org___rank__4222D4EF]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org___rank__4222D4EF]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org___rank__4222D4EF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_subdomain] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_org__publi__3A81B327]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__publi__3A81B327]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__publi__3A81B327]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_keyword] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_org__citat__3B75D760]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__citat__3B75D760]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__citat__3B75D760]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_keyword] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_org__citat__3C69FB99]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__citat__3C69FB99]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__citat__3C69FB99]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_keyword] ADD  DEFAULT (NULL) FOR [citationInKeywordCount]
END


End
GO
/****** Object:  Default [DF___rank_org___rank__3D5E1FD2]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org___rank__3D5E1FD2]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org___rank__3D5E1FD2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org_keyword] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_org__publi__36B12243]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__publi__36B12243]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__publi__36B12243]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_org__citat__37A5467C]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__citat__37A5467C]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__citat__37A5467C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_org__rank__38996AB5]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_org__rank__38996AB5]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_org]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_org__rank__38996AB5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_org] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_mag__publi__31EC6D26]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__publi__31EC6D26]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__publi__31EC6D26]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_subdomain] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_mag__citat__32E0915F]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__citat__32E0915F]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__citat__32E0915F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_subdomain] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_mag__citat__33D4B598]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__citat__33D4B598]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__citat__33D4B598]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_subdomain] ADD  DEFAULT (NULL) FOR [citationInSubdomainCount]
END


End
GO
/****** Object:  Default [DF___rank_maga__rank__34C8D9D1]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_maga__rank__34C8D9D1]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_maga__rank__34C8D9D1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_subdomain] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_mag__publi__2D27B809]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__publi__2D27B809]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__publi__2D27B809]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_keyword] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_mag__citat__2E1BDC42]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__citat__2E1BDC42]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__citat__2E1BDC42]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_keyword] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_mag__citat__2F10007B]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__citat__2F10007B]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__citat__2F10007B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_keyword] ADD  DEFAULT (NULL) FOR [citationInKeywordCount]
END


End
GO
/****** Object:  Default [DF___rank_maga__rank__300424B4]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_maga__rank__300424B4]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_maga__rank__300424B4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine_keyword] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_mag__publi__29572725]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__publi__29572725]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__publi__29572725]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_mag__citat__2A4B4B5E]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_mag__citat__2A4B4B5E]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_mag__citat__2A4B4B5E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_maga__rank__2B3F6F97]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_maga__rank__2B3F6F97]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_magazine]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_maga__rank__2B3F6F97]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_magazine] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_jou__publi__24927208]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__publi__24927208]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__publi__24927208]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_subdomain] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_jou__citat__25869641]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__citat__25869641]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__citat__25869641]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_subdomain] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_jou__citat__267ABA7A]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__citat__267ABA7A]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__citat__267ABA7A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_subdomain] ADD  DEFAULT (NULL) FOR [citationInSubdomainCount]
END


End
GO
/****** Object:  Default [DF___rank_jour__rank__276EDEB3]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jour__rank__276EDEB3]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jour__rank__276EDEB3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_subdomain] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_jou__publi__1FCDBCEB]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__publi__1FCDBCEB]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__publi__1FCDBCEB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_keyword] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_jou__citat__20C1E124]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__citat__20C1E124]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__citat__20C1E124]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_keyword] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_jou__citat__21B6055D]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__citat__21B6055D]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__citat__21B6055D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_keyword] ADD  DEFAULT (NULL) FOR [citationInKeywordCount]
END


End
GO
/****** Object:  Default [DF___rank_jour__rank__22AA2996]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jour__rank__22AA2996]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jour__rank__22AA2996]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal_keyword] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_jou__publi__1BFD2C07]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__publi__1BFD2C07]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__publi__1BFD2C07]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_jou__citat__1CF15040]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jou__citat__1CF15040]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jou__citat__1CF15040]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_jour__rank__1DE57479]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_jour__rank__1DE57479]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_journal]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_jour__rank__1DE57479]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_journal] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_con__publi__173876EA]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__publi__173876EA]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__publi__173876EA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_subdomain] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_con__citat__182C9B23]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__citat__182C9B23]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__citat__182C9B23]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_subdomain] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_con__citat__1920BF5C]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__citat__1920BF5C]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__citat__1920BF5C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_subdomain] ADD  DEFAULT (NULL) FOR [citationInSubdomainCount]
END


End
GO
/****** Object:  Default [DF___rank_conf__rank__1A14E395]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_conf__rank__1A14E395]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_conf__rank__1A14E395]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_subdomain] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_con__publi__1273C1CD]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__publi__1273C1CD]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__publi__1273C1CD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_keyword] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_con__citat__1367E606]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__citat__1367E606]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__citat__1367E606]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_keyword] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_con__citat__145C0A3F]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__citat__145C0A3F]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__citat__145C0A3F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_keyword] ADD  DEFAULT (NULL) FOR [citationInKeywordCount]
END


End
GO
/****** Object:  Default [DF___rank_conf__rank__15502E78]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_conf__rank__15502E78]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_conf__rank__15502E78]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference_keyword] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_con__publi__0EA330E9]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__publi__0EA330E9]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__publi__0EA330E9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_con__citat__0F975522]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_con__citat__0F975522]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_con__citat__0F975522]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_conf__rank__108B795B]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_conf__rank__108B795B]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_conference]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_conf__rank__108B795B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_conference] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_aut__publi__08EA5793]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__publi__08EA5793]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__publi__08EA5793]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_subdomain] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_aut__citat__09DE7BCC]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__citat__09DE7BCC]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__citat__09DE7BCC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_subdomain] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_aut__citat__0AD2A005]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__citat__0AD2A005]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__citat__0AD2A005]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_subdomain] ADD  DEFAULT (NULL) FOR [citationInSubdomainCount]
END


End
GO
/****** Object:  Default [DF___rank_auth__rank__0BC6C43E]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_auth__rank__0BC6C43E]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_auth__rank__0BC6C43E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_subdomain] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_aut__coAut__0CBAE877]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__coAut__0CBAE877]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__coAut__0CBAE877]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_subdomain] ADD  DEFAULT (NULL) FOR [coAuthorCount]
END


End
GO
/****** Object:  Default [DF___rank_aut__publi__03317E3D]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__publi__03317E3D]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__publi__03317E3D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_keyword] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_aut__citat__0425A276]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__citat__0425A276]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__citat__0425A276]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_keyword] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_aut__citat__0519C6AF]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__citat__0519C6AF]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__citat__0519C6AF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_keyword] ADD  DEFAULT (NULL) FOR [citationInKeywordCount]
END


End
GO
/****** Object:  Default [DF___rank_auth__rank__060DEAE8]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_auth__rank__060DEAE8]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_auth__rank__060DEAE8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_keyword] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_aut__coAut__07020F21]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__coAut__07020F21]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author_keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__coAut__07020F21]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author_keyword] ADD  DEFAULT (NULL) FOR [coAuthorCount]
END


End
GO
/****** Object:  Default [DF___rank_aut__publi__7E6CC920]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__publi__7E6CC920]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__publi__7E6CC920]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author] ADD  DEFAULT (NULL) FOR [publicationCount]
END


End
GO
/****** Object:  Default [DF___rank_aut__citat__7F60ED59]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__citat__7F60ED59]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__citat__7F60ED59]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author] ADD  DEFAULT (NULL) FOR [citationCount]
END


End
GO
/****** Object:  Default [DF___rank_auth__rank__00551192]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_auth__rank__00551192]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_auth__rank__00551192]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author] ADD  DEFAULT (NULL) FOR [rank]
END


End
GO
/****** Object:  Default [DF___rank_aut__coAut__014935CB]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF___rank_aut__coAut__014935CB]') AND parent_object_id = OBJECT_ID(N'[dbo].[_rank_author]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF___rank_aut__coAut__014935CB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[_rank_author] ADD  DEFAULT (NULL) FOR [coAuthorCount]
END


End
GO
/****** Object:  Default [DF__conferenc__confe__5AEE82B9]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conferenc__confe__5AEE82B9]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conferenc__confe__5AEE82B9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] ADD  DEFAULT (NULL) FOR [conferenceName]
END


End
GO
/****** Object:  Default [DF__conferenc__websi__5BE2A6F2]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conferenc__websi__5BE2A6F2]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conferenc__websi__5BE2A6F2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] ADD  DEFAULT (NULL) FOR [website]
END


End
GO
/****** Object:  Default [DF__conferenc__organ__5CD6CB2B]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conferenc__organ__5CD6CB2B]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conferenc__organ__5CD6CB2B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] ADD  DEFAULT (NULL) FOR [organization]
END


End
GO
/****** Object:  Default [DF__conferenc__organ__5DCAEF64]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conferenc__organ__5DCAEF64]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conferenc__organ__5DCAEF64]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] ADD  DEFAULT (NULL) FOR [organizedLocation]
END


End
GO
/****** Object:  Default [DF__conferenc__durat__5EBF139D]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conferenc__durat__5EBF139D]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conferenc__durat__5EBF139D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] ADD  DEFAULT (NULL) FOR [duration]
END


End
GO
/****** Object:  Default [DF__conferenc__yearS__5FB337D6]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conferenc__yearS__5FB337D6]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conferenc__yearS__5FB337D6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] ADD  DEFAULT (NULL) FOR [yearStart]
END


End
GO
/****** Object:  Default [DF__conferenc__yearE__60A75C0F]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conferenc__yearE__60A75C0F]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conferenc__yearE__60A75C0F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] ADD  DEFAULT (NULL) FOR [yearEnd]
END


End
GO
/****** Object:  Default [DF__conference__url__619B8048]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conference__url__619B8048]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conference__url__619B8048]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference] ADD  DEFAULT (NULL) FOR [url]
END


End
GO
/****** Object:  Default [DF__org__orgName__787EE5A0]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__org__orgName__787EE5A0]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__org__orgName__787EE5A0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[org] ADD  DEFAULT (NULL) FOR [orgName]
END


End
GO
/****** Object:  Default [DF__org__website__797309D9]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__org__website__797309D9]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__org__website__797309D9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[org] ADD  DEFAULT (NULL) FOR [website]
END


End
GO
/****** Object:  Default [DF__org__continent__7A672E12]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__org__continent__7A672E12]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__org__continent__7A672E12]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[org] ADD  DEFAULT (NULL) FOR [continent]
END


End
GO
/****** Object:  Default [DF__org__idOrgParent__7B5B524B]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__org__idOrgParent__7B5B524B]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__org__idOrgParent__7B5B524B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[org] ADD  DEFAULT (NULL) FOR [idOrgParent]
END


End
GO
/****** Object:  Default [DF__org__h_index__7C4F7684]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__org__h_index__7C4F7684]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__org__h_index__7C4F7684]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[org] ADD  DEFAULT (NULL) FOR [h_index]
END


End
GO
/****** Object:  Default [DF__org__url__7D439ABD]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__org__url__7D439ABD]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__org__url__7D439ABD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[org] ADD  DEFAULT (NULL) FOR [url]
END


End
GO
/****** Object:  Default [DF__magazine__magazi__71D1E811]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__magazine__magazi__71D1E811]') AND parent_object_id = OBJECT_ID(N'[dbo].[magazine]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__magazine__magazi__71D1E811]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[magazine] ADD  DEFAULT (NULL) FOR [magazineName]
END


End
GO
/****** Object:  Default [DF__magazine__websit__72C60C4A]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__magazine__websit__72C60C4A]') AND parent_object_id = OBJECT_ID(N'[dbo].[magazine]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__magazine__websit__72C60C4A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[magazine] ADD  DEFAULT (NULL) FOR [website]
END


End
GO
/****** Object:  Default [DF__magazine__yearSt__73BA3083]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__magazine__yearSt__73BA3083]') AND parent_object_id = OBJECT_ID(N'[dbo].[magazine]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__magazine__yearSt__73BA3083]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[magazine] ADD  DEFAULT (NULL) FOR [yearStart]
END


End
GO
/****** Object:  Default [DF__magazine__yearEn__74AE54BC]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__magazine__yearEn__74AE54BC]') AND parent_object_id = OBJECT_ID(N'[dbo].[magazine]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__magazine__yearEn__74AE54BC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[magazine] ADD  DEFAULT (NULL) FOR [yearEnd]
END


End
GO
/****** Object:  Default [DF__magazine__organi__75A278F5]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__magazine__organi__75A278F5]') AND parent_object_id = OBJECT_ID(N'[dbo].[magazine]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__magazine__organi__75A278F5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[magazine] ADD  DEFAULT (NULL) FOR [organization]
END


End
GO
/****** Object:  Default [DF__magazine__url__76969D2E]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__magazine__url__76969D2E]') AND parent_object_id = OBJECT_ID(N'[dbo].[magazine]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__magazine__url__76969D2E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[magazine] ADD  DEFAULT (NULL) FOR [url]
END


End
GO
/****** Object:  Default [DF__keyword__keyword__6E01572D]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__keyword__keyword__6E01572D]') AND parent_object_id = OBJECT_ID(N'[dbo].[keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__keyword__keyword__6E01572D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[keyword] ADD  DEFAULT (NULL) FOR [keyword]
END


End
GO
/****** Object:  Default [DF__keyword__stemmin__6EF57B66]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__keyword__stemmin__6EF57B66]') AND parent_object_id = OBJECT_ID(N'[dbo].[keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__keyword__stemmin__6EF57B66]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[keyword] ADD  DEFAULT (NULL) FOR [stemmingVariations]
END


End
GO
/****** Object:  Default [DF__keyword__url__6FE99F9F]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__keyword__url__6FE99F9F]') AND parent_object_id = OBJECT_ID(N'[dbo].[keyword]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__keyword__url__6FE99F9F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[keyword] ADD  DEFAULT (NULL) FOR [url]
END


End
GO
/****** Object:  Default [DF__journal__journal__6754599E]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__journal__journal__6754599E]') AND parent_object_id = OBJECT_ID(N'[dbo].[journal]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__journal__journal__6754599E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[journal] ADD  DEFAULT (NULL) FOR [journalName]
END


End
GO
/****** Object:  Default [DF__journal__website__68487DD7]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__journal__website__68487DD7]') AND parent_object_id = OBJECT_ID(N'[dbo].[journal]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__journal__website__68487DD7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[journal] ADD  DEFAULT (NULL) FOR [website]
END


End
GO
/****** Object:  Default [DF__journal__yearSta__693CA210]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__journal__yearSta__693CA210]') AND parent_object_id = OBJECT_ID(N'[dbo].[journal]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__journal__yearSta__693CA210]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[journal] ADD  DEFAULT (NULL) FOR [yearStart]
END


End
GO
/****** Object:  Default [DF__journal__yearEnd__6A30C649]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__journal__yearEnd__6A30C649]') AND parent_object_id = OBJECT_ID(N'[dbo].[journal]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__journal__yearEnd__6A30C649]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[journal] ADD  DEFAULT (NULL) FOR [yearEnd]
END


End
GO
/****** Object:  Default [DF__journal__organiz__6B24EA82]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__journal__organiz__6B24EA82]') AND parent_object_id = OBJECT_ID(N'[dbo].[journal]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__journal__organiz__6B24EA82]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[journal] ADD  DEFAULT (NULL) FOR [organization]
END


End
GO
/****** Object:  Default [DF__journal__url__6C190EBB]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__journal__url__6C190EBB]') AND parent_object_id = OBJECT_ID(N'[dbo].[journal]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__journal__url__6C190EBB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[journal] ADD  DEFAULT (NULL) FOR [url]
END


End
GO
/****** Object:  Default [DF__domain__domainNa__656C112C]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__domain__domainNa__656C112C]') AND parent_object_id = OBJECT_ID(N'[dbo].[domain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__domain__domainNa__656C112C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[domain] ADD  DEFAULT (NULL) FOR [domainName]
END


End
GO
/****** Object:  Default [DF__conference__year__6383C8BA]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__conference__year__6383C8BA]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference_pcmember]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__conference__year__6383C8BA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[conference_pcmember] ADD  DEFAULT (NULL) FOR [year]
END


End
GO
/****** Object:  Default [DF__paper__doi__7F2BE32F]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__doi__7F2BE32F]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__doi__7F2BE32F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [doi]
END


End
GO
/****** Object:  Default [DF__paper__isbn__00200768]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__isbn__00200768]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__isbn__00200768]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [isbn]
END


End
GO
/****** Object:  Default [DF__paper__url__01142BA1]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__url__01142BA1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__url__01142BA1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [url]
END


End
GO
/****** Object:  Default [DF__paper__title__02084FDA]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__title__02084FDA]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__title__02084FDA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [title]
END


End
GO
/****** Object:  Default [DF__paper__abstract__02FC7413]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__abstract__02FC7413]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__abstract__02FC7413]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [abstract]
END


End
GO
/****** Object:  Default [DF__paper__volume__03F0984C]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__volume__03F0984C]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__volume__03F0984C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [volume]
END


End
GO
/****** Object:  Default [DF__paper__pages__04E4BC85]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__pages__04E4BC85]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__pages__04E4BC85]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [pages]
END


End
GO
/****** Object:  Default [DF__paper__year__05D8E0BE]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__year__05D8E0BE]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__year__05D8E0BE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [year]
END


End
GO
/****** Object:  Default [DF__paper__bibTex__06CD04F7]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__bibTex__06CD04F7]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__bibTex__06CD04F7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [bibTex]
END


End
GO
/****** Object:  Default [DF__paper__endNote__07C12930]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__endNote__07C12930]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__endNote__07C12930]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [endNote]
END


End
GO
/****** Object:  Default [DF__paper__idJournal__08B54D69]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__idJournal__08B54D69]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__idJournal__08B54D69]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [idJournal]
END


End
GO
/****** Object:  Default [DF__paper__idConfere__09A971A2]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__idConfere__09A971A2]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__idConfere__09A971A2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [idConference]
END


End
GO
/****** Object:  Default [DF__paper__idMagazin__0A9D95DB]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__idMagazin__0A9D95DB]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__idMagazin__0A9D95DB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [idMagazine]
END


End
GO
/****** Object:  Default [DF__paper__version__0B91BA14]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__version__0B91BA14]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__version__0B91BA14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [version]
END


End
GO
/****** Object:  Default [DF__paper__paperFile__0C85DE4D]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper__paperFile__0C85DE4D]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper__paperFile__0C85DE4D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper] ADD  DEFAULT (NULL) FOR [paperFile]
END


End
GO
/****** Object:  Default [DF__subdomain__subdo__1F98B2C1]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__subdomain__subdo__1F98B2C1]') AND parent_object_id = OBJECT_ID(N'[dbo].[subdomain]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__subdomain__subdo__1F98B2C1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[subdomain] ADD  DEFAULT (NULL) FOR [subdomainName]
END


End
GO
/****** Object:  Default [DF__author__authorNa__4CA06362]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__authorNa__4CA06362]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__authorNa__4CA06362]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] ADD  DEFAULT (NULL) FOR [authorName]
END


End
GO
/****** Object:  Default [DF__author__image__4D94879B]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__image__4D94879B]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__image__4D94879B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] ADD  DEFAULT (NULL) FOR [image]
END


End
GO
/****** Object:  Default [DF__author__emailAdd__4E88ABD4]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__emailAdd__4E88ABD4]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__emailAdd__4E88ABD4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] ADD  DEFAULT (NULL) FOR [emailAddress]
END


End
GO
/****** Object:  Default [DF__author__website__4F7CD00D]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__website__4F7CD00D]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__website__4F7CD00D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] ADD  DEFAULT (NULL) FOR [website]
END


End
GO
/****** Object:  Default [DF__author__idOrg__5070F446]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__idOrg__5070F446]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__idOrg__5070F446]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] ADD  DEFAULT (NULL) FOR [idOrg]
END


End
GO
/****** Object:  Default [DF__author__h_index__5165187F]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__h_index__5165187F]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__h_index__5165187F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] ADD  DEFAULT (NULL) FOR [h_index]
END


End
GO
/****** Object:  Default [DF__author__g_index__52593CB8]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__g_index__52593CB8]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__g_index__52593CB8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] ADD  DEFAULT (NULL) FOR [g_index]
END


End
GO
/****** Object:  Default [DF__author__url__534D60F1]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__author__url__534D60F1]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__author__url__534D60F1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[author] ADD  DEFAULT (NULL) FOR [url]
END


End
GO
/****** Object:  Default [DF__paper_rev__ratin__114A936A]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper_rev__ratin__114A936A]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_reviewer]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper_rev__ratin__114A936A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper_reviewer] ADD  DEFAULT (NULL) FOR [rating]
END


End
GO
/****** Object:  Default [DF__paper_rev__conte__123EB7A3]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper_rev__conte__123EB7A3]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_reviewer]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper_rev__conte__123EB7A3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper_reviewer] ADD  DEFAULT (NULL) FOR [content]
END


End
GO
/****** Object:  Default [DF__paper_pap__citat__0F624AF8]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__paper_pap__citat__0F624AF8]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_paper]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__paper_pap__citat__0F624AF8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[paper_paper] ADD  DEFAULT (NULL) FOR [citationContext]
END


End
GO
/****** Object:  Default [DF__comment__rating__5812160E]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__comment__rating__5812160E]') AND parent_object_id = OBJECT_ID(N'[dbo].[comment]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__comment__rating__5812160E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[comment] ADD  DEFAULT (NULL) FOR [rating]
END


End
GO
/****** Object:  Default [DF__comment__content__59063A47]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__comment__content__59063A47]') AND parent_object_id = OBJECT_ID(N'[dbo].[comment]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__comment__content__59063A47]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[comment] ADD  DEFAULT (NULL) FOR [content]
END


End
GO
/****** Object:  Default [DF__authorins__insta__5629CD9C]    Script Date: 08/26/2011 04:28:18 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__authorins__insta__5629CD9C]') AND parent_object_id = OBJECT_ID(N'[dbo].[authorinstance]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__authorins__insta__5629CD9C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[authorinstance] ADD  DEFAULT (NULL) FOR [instanceName]
END


End
GO
/****** Object:  ForeignKey [org$fk_Org_Org1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[org$fk_Org_Org1]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
ALTER TABLE [dbo].[org]  WITH NOCHECK ADD  CONSTRAINT [org$fk_Org_Org1] FOREIGN KEY([idOrgParent])
REFERENCES [dbo].[org] ([idOrg])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[org$fk_Org_Org1]') AND parent_object_id = OBJECT_ID(N'[dbo].[org]'))
ALTER TABLE [dbo].[org] CHECK CONSTRAINT [org$fk_Org_Org1]
GO
/****** Object:  ForeignKey [conference_pcmember$fk_Conference_has_pcMember_Conference1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[conference_pcmember$fk_Conference_has_pcMember_Conference1]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference_pcmember]'))
ALTER TABLE [dbo].[conference_pcmember]  WITH NOCHECK ADD  CONSTRAINT [conference_pcmember$fk_Conference_has_pcMember_Conference1] FOREIGN KEY([idConference])
REFERENCES [dbo].[conference] ([idConference])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[conference_pcmember$fk_Conference_has_pcMember_Conference1]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference_pcmember]'))
ALTER TABLE [dbo].[conference_pcmember] CHECK CONSTRAINT [conference_pcmember$fk_Conference_has_pcMember_Conference1]
GO
/****** Object:  ForeignKey [conference_pcmember$fk_Conference_has_pcMember_pcMember1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[conference_pcmember$fk_Conference_has_pcMember_pcMember1]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference_pcmember]'))
ALTER TABLE [dbo].[conference_pcmember]  WITH NOCHECK ADD  CONSTRAINT [conference_pcmember$fk_Conference_has_pcMember_pcMember1] FOREIGN KEY([idPCMember])
REFERENCES [dbo].[pcmember] ([idPCMember])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[conference_pcmember$fk_Conference_has_pcMember_pcMember1]') AND parent_object_id = OBJECT_ID(N'[dbo].[conference_pcmember]'))
ALTER TABLE [dbo].[conference_pcmember] CHECK CONSTRAINT [conference_pcmember$fk_Conference_has_pcMember_pcMember1]
GO
/****** Object:  ForeignKey [paper$fk_Paper_Conference1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper$fk_Paper_Conference1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
ALTER TABLE [dbo].[paper]  WITH NOCHECK ADD  CONSTRAINT [paper$fk_Paper_Conference1] FOREIGN KEY([idConference])
REFERENCES [dbo].[conference] ([idConference])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper$fk_Paper_Conference1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
ALTER TABLE [dbo].[paper] CHECK CONSTRAINT [paper$fk_Paper_Conference1]
GO
/****** Object:  ForeignKey [paper$fk_Paper_Journal1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper$fk_Paper_Journal1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
ALTER TABLE [dbo].[paper]  WITH NOCHECK ADD  CONSTRAINT [paper$fk_Paper_Journal1] FOREIGN KEY([idJournal])
REFERENCES [dbo].[journal] ([idJournal])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper$fk_Paper_Journal1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
ALTER TABLE [dbo].[paper] CHECK CONSTRAINT [paper$fk_Paper_Journal1]
GO
/****** Object:  ForeignKey [paper$fk_Paper_Magazine1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper$fk_Paper_Magazine1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
ALTER TABLE [dbo].[paper]  WITH NOCHECK ADD  CONSTRAINT [paper$fk_Paper_Magazine1] FOREIGN KEY([idMagazine])
REFERENCES [dbo].[magazine] ([idMagazine])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper$fk_Paper_Magazine1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper]'))
ALTER TABLE [dbo].[paper] CHECK CONSTRAINT [paper$fk_Paper_Magazine1]
GO
/****** Object:  ForeignKey [subdomain$fk_Subdomain_Domain1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[subdomain$fk_Subdomain_Domain1]') AND parent_object_id = OBJECT_ID(N'[dbo].[subdomain]'))
ALTER TABLE [dbo].[subdomain]  WITH NOCHECK ADD  CONSTRAINT [subdomain$fk_Subdomain_Domain1] FOREIGN KEY([idDomain])
REFERENCES [dbo].[domain] ([idDomain])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[subdomain$fk_Subdomain_Domain1]') AND parent_object_id = OBJECT_ID(N'[dbo].[subdomain]'))
ALTER TABLE [dbo].[subdomain] CHECK CONSTRAINT [subdomain$fk_Subdomain_Domain1]
GO
/****** Object:  ForeignKey [author$fk_Author_Org]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[author$fk_Author_Org]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
ALTER TABLE [dbo].[author]  WITH NOCHECK ADD  CONSTRAINT [author$fk_Author_Org] FOREIGN KEY([idOrg])
REFERENCES [dbo].[org] ([idOrg])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[author$fk_Author_Org]') AND parent_object_id = OBJECT_ID(N'[dbo].[author]'))
ALTER TABLE [dbo].[author] CHECK CONSTRAINT [author$fk_Author_Org]
GO
/****** Object:  ForeignKey [subdomain_paper$fk_Subdomain_has_Paper_Paper1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[subdomain_paper$fk_Subdomain_has_Paper_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[subdomain_paper]'))
ALTER TABLE [dbo].[subdomain_paper]  WITH NOCHECK ADD  CONSTRAINT [subdomain_paper$fk_Subdomain_has_Paper_Paper1] FOREIGN KEY([idPaper])
REFERENCES [dbo].[paper] ([idPaper])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[subdomain_paper$fk_Subdomain_has_Paper_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[subdomain_paper]'))
ALTER TABLE [dbo].[subdomain_paper] CHECK CONSTRAINT [subdomain_paper$fk_Subdomain_has_Paper_Paper1]
GO
/****** Object:  ForeignKey [subdomain_paper$fk_Subdomain_has_Paper_Subdomain1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[subdomain_paper$fk_Subdomain_has_Paper_Subdomain1]') AND parent_object_id = OBJECT_ID(N'[dbo].[subdomain_paper]'))
ALTER TABLE [dbo].[subdomain_paper]  WITH NOCHECK ADD  CONSTRAINT [subdomain_paper$fk_Subdomain_has_Paper_Subdomain1] FOREIGN KEY([idSubdomain])
REFERENCES [dbo].[subdomain] ([idSubdomain])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[subdomain_paper$fk_Subdomain_has_Paper_Subdomain1]') AND parent_object_id = OBJECT_ID(N'[dbo].[subdomain_paper]'))
ALTER TABLE [dbo].[subdomain_paper] CHECK CONSTRAINT [subdomain_paper$fk_Subdomain_has_Paper_Subdomain1]
GO
/****** Object:  ForeignKey [paper_reviewer$fk_Paper_has_Reviewer_Paper1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_reviewer$fk_Paper_has_Reviewer_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_reviewer]'))
ALTER TABLE [dbo].[paper_reviewer]  WITH NOCHECK ADD  CONSTRAINT [paper_reviewer$fk_Paper_has_Reviewer_Paper1] FOREIGN KEY([idPaper])
REFERENCES [dbo].[paper] ([idPaper])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_reviewer$fk_Paper_has_Reviewer_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_reviewer]'))
ALTER TABLE [dbo].[paper_reviewer] CHECK CONSTRAINT [paper_reviewer$fk_Paper_has_Reviewer_Paper1]
GO
/****** Object:  ForeignKey [paper_reviewer$fk_Paper_has_Reviewer_Reviewer1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_reviewer$fk_Paper_has_Reviewer_Reviewer1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_reviewer]'))
ALTER TABLE [dbo].[paper_reviewer]  WITH NOCHECK ADD  CONSTRAINT [paper_reviewer$fk_Paper_has_Reviewer_Reviewer1] FOREIGN KEY([idReviewer])
REFERENCES [dbo].[reviewer] ([idReviewer])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_reviewer$fk_Paper_has_Reviewer_Reviewer1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_reviewer]'))
ALTER TABLE [dbo].[paper_reviewer] CHECK CONSTRAINT [paper_reviewer$fk_Paper_has_Reviewer_Reviewer1]
GO
/****** Object:  ForeignKey [paper_paper$fk_Paper_has_Paper_Paper1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_paper$fk_Paper_has_Paper_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_paper]'))
ALTER TABLE [dbo].[paper_paper]  WITH NOCHECK ADD  CONSTRAINT [paper_paper$fk_Paper_has_Paper_Paper1] FOREIGN KEY([idPaper])
REFERENCES [dbo].[paper] ([idPaper])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_paper$fk_Paper_has_Paper_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_paper]'))
ALTER TABLE [dbo].[paper_paper] CHECK CONSTRAINT [paper_paper$fk_Paper_has_Paper_Paper1]
GO
/****** Object:  ForeignKey [paper_paper$fk_Paper_has_Paper_Paper2]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_paper$fk_Paper_has_Paper_Paper2]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_paper]'))
ALTER TABLE [dbo].[paper_paper]  WITH NOCHECK ADD  CONSTRAINT [paper_paper$fk_Paper_has_Paper_Paper2] FOREIGN KEY([idPaperRef])
REFERENCES [dbo].[paper] ([idPaper])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_paper$fk_Paper_has_Paper_Paper2]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_paper]'))
ALTER TABLE [dbo].[paper_paper] CHECK CONSTRAINT [paper_paper$fk_Paper_has_Paper_Paper2]
GO
/****** Object:  ForeignKey [paper_keyword$fk_Paper_has_Keyword_Keyword1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_keyword$fk_Paper_has_Keyword_Keyword1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_keyword]'))
ALTER TABLE [dbo].[paper_keyword]  WITH NOCHECK ADD  CONSTRAINT [paper_keyword$fk_Paper_has_Keyword_Keyword1] FOREIGN KEY([idKeyword])
REFERENCES [dbo].[keyword] ([idKeyword])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_keyword$fk_Paper_has_Keyword_Keyword1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_keyword]'))
ALTER TABLE [dbo].[paper_keyword] CHECK CONSTRAINT [paper_keyword$fk_Paper_has_Keyword_Keyword1]
GO
/****** Object:  ForeignKey [paper_keyword$fk_Paper_has_Keyword_Paper1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_keyword$fk_Paper_has_Keyword_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_keyword]'))
ALTER TABLE [dbo].[paper_keyword]  WITH NOCHECK ADD  CONSTRAINT [paper_keyword$fk_Paper_has_Keyword_Paper1] FOREIGN KEY([idPaper])
REFERENCES [dbo].[paper] ([idPaper])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[paper_keyword$fk_Paper_has_Keyword_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[paper_keyword]'))
ALTER TABLE [dbo].[paper_keyword] CHECK CONSTRAINT [paper_keyword$fk_Paper_has_Keyword_Paper1]
GO
/****** Object:  ForeignKey [comment$fk_Comment_Paper1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[comment$fk_Comment_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[comment]'))
ALTER TABLE [dbo].[comment]  WITH NOCHECK ADD  CONSTRAINT [comment$fk_Comment_Paper1] FOREIGN KEY([idPaper])
REFERENCES [dbo].[paper] ([idPaper])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[comment$fk_Comment_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[comment]'))
ALTER TABLE [dbo].[comment] CHECK CONSTRAINT [comment$fk_Comment_Paper1]
GO
/****** Object:  ForeignKey [authorinstance$fk_authorInstance_Author1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[authorinstance$fk_authorInstance_Author1]') AND parent_object_id = OBJECT_ID(N'[dbo].[authorinstance]'))
ALTER TABLE [dbo].[authorinstance]  WITH NOCHECK ADD  CONSTRAINT [authorinstance$fk_authorInstance_Author1] FOREIGN KEY([idAuthor])
REFERENCES [dbo].[author] ([idAuthor])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[authorinstance$fk_authorInstance_Author1]') AND parent_object_id = OBJECT_ID(N'[dbo].[authorinstance]'))
ALTER TABLE [dbo].[authorinstance] CHECK CONSTRAINT [authorinstance$fk_authorInstance_Author1]
GO
/****** Object:  ForeignKey [author_paper$fk_Author_has_Paper_Author1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[author_paper$fk_Author_has_Paper_Author1]') AND parent_object_id = OBJECT_ID(N'[dbo].[author_paper]'))
ALTER TABLE [dbo].[author_paper]  WITH NOCHECK ADD  CONSTRAINT [author_paper$fk_Author_has_Paper_Author1] FOREIGN KEY([idAuthor])
REFERENCES [dbo].[author] ([idAuthor])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[author_paper$fk_Author_has_Paper_Author1]') AND parent_object_id = OBJECT_ID(N'[dbo].[author_paper]'))
ALTER TABLE [dbo].[author_paper] CHECK CONSTRAINT [author_paper$fk_Author_has_Paper_Author1]
GO
/****** Object:  ForeignKey [author_paper$fk_Author_has_Paper_Paper1]    Script Date: 08/26/2011 04:28:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[author_paper$fk_Author_has_Paper_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[author_paper]'))
ALTER TABLE [dbo].[author_paper]  WITH NOCHECK ADD  CONSTRAINT [author_paper$fk_Author_has_Paper_Paper1] FOREIGN KEY([idPaper])
REFERENCES [dbo].[paper] ([idPaper])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[author_paper$fk_Author_has_Paper_Paper1]') AND parent_object_id = OBJECT_ID(N'[dbo].[author_paper]'))
ALTER TABLE [dbo].[author_paper] CHECK CONSTRAINT [author_paper$fk_Author_has_Paper_Paper1]
GO
