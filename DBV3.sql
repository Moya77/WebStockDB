USE [master]
GO
/****** Object:  Database [WebStock]    Script Date: 14/4/2023 19:37:40 ******/
CREATE DATABASE [WebStock]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WebStock', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLSERVERDEV\MSSQL\DATA\WebStock.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WebStock_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLSERVERDEV\MSSQL\DATA\WebStock_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [WebStock] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WebStock].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WebStock] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WebStock] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WebStock] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WebStock] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WebStock] SET ARITHABORT OFF 
GO
ALTER DATABASE [WebStock] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WebStock] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WebStock] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WebStock] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WebStock] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WebStock] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WebStock] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WebStock] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WebStock] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WebStock] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WebStock] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WebStock] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WebStock] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WebStock] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WebStock] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WebStock] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WebStock] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WebStock] SET RECOVERY FULL 
GO
ALTER DATABASE [WebStock] SET  MULTI_USER 
GO
ALTER DATABASE [WebStock] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WebStock] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WebStock] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WebStock] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WebStock] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WebStock] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'WebStock', N'ON'
GO
ALTER DATABASE [WebStock] SET QUERY_STORE = ON
GO
ALTER DATABASE [WebStock] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [WebStock]
GO
/****** Object:  Table [dbo].[Inventario]    Script Date: 14/4/2023 19:37:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventario](
	[Numero_lote] [int] NOT NULL,
	[Id_producto] [int] NOT NULL,
	[Id_provedor] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Fecha_fabricacion] [date] NOT NULL,
	[Fecha_expiracion] [date] NOT NULL,
 CONSTRAINT [PK_Inventario] PRIMARY KEY CLUSTERED 
(
	[Numero_lote] ASC,
	[Id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 14/4/2023 19:37:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[Id_producto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [ID_Product] PRIMARY KEY CLUSTERED 
(
	[Id_producto] ASC,
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[InformeInventario]    Script Date: 14/4/2023 19:37:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[InformeInventario]
AS
SELECT        dbo.Productos.Nombre, dbo.Inventario.Cantidad, dbo.Inventario.Fecha_expiracion, dbo.Inventario.Numero_lote
FROM            dbo.Inventario INNER JOIN
                         dbo.Productos ON dbo.Productos.Id_producto = dbo.Inventario.Id_producto
GO
/****** Object:  Table [dbo].[Provedores]    Script Date: 14/4/2023 19:37:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provedores](
	[Id_provedor] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Provedores] PRIMARY KEY CLUSTERED 
(
	[Id_provedor] ASC,
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GetInfoLote]    Script Date: 14/4/2023 19:37:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInfoLote]
@Num_lote int
AS
begin
SELECT Nombre,Cantidad,Fecha_expiracion FROM InformeInventario WHERE Numero_lote = @Num_lote
end
GO
/****** Object:  StoredProcedure [dbo].[RegIngresoInventario]    Script Date: 14/4/2023 19:37:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegIngresoInventario]
@Producto VARCHAR(50),
@NumeroLote INT,
@Cantidad INT,
@FechaFabricacion DATE,
@Provedor VARCHAR(50),
@FechaCaducidad DATE
AS
BEGIN
 IF(SELECT COUNT(*) FROM dbo.Productos where Nombre =@Producto )=0
 BEGIN
 INSERT INTO Productos VALUES(@Producto);
 END
 IF (SELECT COUNT(*) FROM dbo.Provedores WHERE Nombre=@Provedor)=0
 BEGIN
 INSERT INTO Provedores VALUES(@Provedor);
 END
 IF(SELECT COUNT(*) FROM dbo.Inventario 
 WHERE Numero_lote=@NumeroLote and Id_producto=(SELECT Id_producto FROM Productos WHERE Nombre=@Producto))=0
 BEGIN
 INSERT INTO dbo.Inventario VALUES (@NumeroLote,(SELECT Id_producto FROM Productos WHERE Nombre=@Producto)
 ,(SELECT Id_provedor FROM Provedores WHERE Nombre=@Provedor),@Cantidad,@FechaFabricacion,@FechaCaducidad);
 END
 ELSE
 BEGIN
 UPDATE dbo.Inventario SET Id_provedor=(SELECT Id_provedor FROM Provedores WHERE Nombre=@Provedor)
 , Cantidad = @Cantidad, Fecha_fabricacion =@FechaFabricacion, Fecha_expiracion= @FechaCaducidad;
 END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Inventario"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Productos"
            Begin Extent = 
               Top = 6
               Left = 260
               Bottom = 102
               Right = 430
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'InformeInventario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'InformeInventario'
GO
USE [master]
GO
ALTER DATABASE [WebStock] SET  READ_WRITE 
GO
