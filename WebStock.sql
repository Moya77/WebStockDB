USE [master]
GO
/****** Object:  Database [WebStock]    Script Date: 16/4/2023 09:15:44 ******/
CREATE DATABASE [WebStock]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WebStock', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESSDEV\MSSQL\DATA\WebStock.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WebStock_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESSDEV\MSSQL\DATA\WebStock_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [WebStock] SET COMPATIBILITY_LEVEL = 150
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
ALTER DATABASE [WebStock] SET  ENABLE_BROKER 
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
ALTER DATABASE [WebStock] SET QUERY_STORE = OFF
GO
USE [WebStock]
GO
/****** Object:  Table [dbo].[Inventario]    Script Date: 16/4/2023 09:15:44 ******/
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
/****** Object:  Table [dbo].[Productos]    Script Date: 16/4/2023 09:15:44 ******/
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
/****** Object:  Table [dbo].[Provedores]    Script Date: 16/4/2023 09:15:44 ******/
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
/****** Object:  View [dbo].[InformeInventario]    Script Date: 16/4/2023 09:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[InformeInventario]
AS
SELECT        dbo.Productos.Nombre, dbo.Inventario.Cantidad, dbo.Inventario.Fecha_expiracion, dbo.Inventario.Numero_lote, dbo.Provedores.Nombre AS Nombre_provedor, dbo.Inventario.Fecha_fabricacion
FROM            dbo.Inventario INNER JOIN
                         dbo.Productos ON dbo.Productos.Id_producto = dbo.Inventario.Id_producto INNER JOIN
                         dbo.Provedores ON dbo.Inventario.Id_provedor = dbo.Provedores.Id_provedor
GO
/****** Object:  Table [dbo].[Salidas]    Script Date: 16/4/2023 09:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salidas](
	[Id_producto] [varchar](50) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Fecha_salida] [date] NOT NULL,
	[Destino] [varchar](50) NOT NULL,
	[Lote] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GetFaltantes]    Script Date: 16/4/2023 09:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetFaltantes]
AS
begin

SELECT * FROM InformeInventario WHERE Cantidad < 0

end
GO
/****** Object:  StoredProcedure [dbo].[GetInfoLote]    Script Date: 16/4/2023 09:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInfoLote]
@Num_lote int
AS
begin
if @Num_lote>0
begin
SELECT * FROM InformeInventario WHERE Numero_lote = @Num_lote and Cantidad>0;
end
if @Num_lote=0
begin 
SELECT * FROM InformeInventario;
end
end

GO
/****** Object:  StoredProcedure [dbo].[GetProductos]    Script Date: 16/4/2023 09:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductos]
AS
begin

SELECT Nombre FROM Productos;

end
GO
/****** Object:  StoredProcedure [dbo].[GetProvedores]    Script Date: 16/4/2023 09:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProvedores]
AS
begin

SELECT Nombre FROM Provedores;

end

GO
/****** Object:  StoredProcedure [dbo].[RegIngresoInventario]    Script Date: 16/4/2023 09:15:44 ******/
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
/****** Object:  StoredProcedure [dbo].[RegSalidaInventario]    Script Date: 16/4/2023 09:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegSalidaInventario]
@Producto VARCHAR(50),
@NumeroLote INT,
@Cantidad INT,
@FechaSalida DATE,
@Destino VARCHAR(50)
AS
BEGIN
INSERT INTO Salidas VALUES ((SELECT Id_producto FROM Productos WHERE Nombre=@Producto),@Cantidad,@FechaSalida,@Destino,@NumeroLote);
END
GO
USE [master]
GO
ALTER DATABASE [WebStock] SET  READ_WRITE 
GO
