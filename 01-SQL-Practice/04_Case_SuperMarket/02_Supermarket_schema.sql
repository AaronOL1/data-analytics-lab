USE [SUPERMERCADO]
GO
/****** Object:  Table [dbo].[CATEGORIA]    Script Date: 2/2/2026 23:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIA](
	[Categoria_id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[Categoria_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLIENTE]    Script Date: 2/2/2026 23:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE](
	[Cliente_id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](30) NULL,
	[Cedula] [char](10) NULL,
	[Ciudad] [nvarchar](20) NULL,
 CONSTRAINT [PK_CLIENTE] PRIMARY KEY CLUSTERED 
(
	[Cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACTURA_CABECERA]    Script Date: 2/2/2026 23:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACTURA_CABECERA](
	[Factura_cabecera_id] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[Forma_pago_id] [int] NULL,
	[Cliente_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Factura_cabecera_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACTURA_DETALLE]    Script Date: 2/2/2026 23:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACTURA_DETALLE](
	[Factura_detalle_id] [int] IDENTITY(1,1) NOT NULL,
	[Cantidad] [numeric](6, 2) NULL,
	[Precio] [decimal](6, 2) NULL,
	[Factura_cabecera_id] [int] NULL,
	[Producto_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Factura_detalle_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FORMA_PAGO]    Script Date: 2/2/2026 23:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FORMA_PAGO](
	[Forma_pago_id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[Forma_pago_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTO]    Script Date: 2/2/2026 23:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO](
	[Producto_id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Marca] [varchar](20) NULL,
	[Categoria_id] [int] NULL,
	[Proveedor_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Producto_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROVEEDOR]    Script Date: 2/2/2026 23:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROVEEDOR](
	[Proveedor_id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Ruc] [varchar](13) NULL,
PRIMARY KEY CLUSTERED 
(
	[Proveedor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CATEGORIA] ON 

INSERT [dbo].[CATEGORIA] ([Categoria_id], [Nombre]) VALUES (1, N'LACTEOS')
INSERT [dbo].[CATEGORIA] ([Categoria_id], [Nombre]) VALUES (2, N'CARNES')
INSERT [dbo].[CATEGORIA] ([Categoria_id], [Nombre]) VALUES (3, N'AVES')
INSERT [dbo].[CATEGORIA] ([Categoria_id], [Nombre]) VALUES (4, N'GASEOSAS')
INSERT [dbo].[CATEGORIA] ([Categoria_id], [Nombre]) VALUES (5, N'ABASTOS')
INSERT [dbo].[CATEGORIA] ([Categoria_id], [Nombre]) VALUES (6, N'LIMPIEZA')
INSERT [dbo].[CATEGORIA] ([Categoria_id], [Nombre]) VALUES (7, N'FRUTAS Y VERDURAS')
SET IDENTITY_INSERT [dbo].[CATEGORIA] OFF
GO
SET IDENTITY_INSERT [dbo].[CLIENTE] ON 

INSERT [dbo].[CLIENTE] ([Cliente_id], [Nombre], [Cedula], [Ciudad]) VALUES (1, N'Samira', N'1234567890', N'Quito')
INSERT [dbo].[CLIENTE] ([Cliente_id], [Nombre], [Cedula], [Ciudad]) VALUES (2, N'Xiomara', N'1234567891', N'Macas')
INSERT [dbo].[CLIENTE] ([Cliente_id], [Nombre], [Cedula], [Ciudad]) VALUES (3, N'Matias', N'1234567892', N'Guayaquil')
INSERT [dbo].[CLIENTE] ([Cliente_id], [Nombre], [Cedula], [Ciudad]) VALUES (5, N'Daniela', N'1234567894', N'Quito')
INSERT [dbo].[CLIENTE] ([Cliente_id], [Nombre], [Cedula], [Ciudad]) VALUES (6, N'Aaron', N'1234567895', N'Esmeraldas')
INSERT [dbo].[CLIENTE] ([Cliente_id], [Nombre], [Cedula], [Ciudad]) VALUES (7, N'Xavier', N'1234567896', N'Quito')
INSERT [dbo].[CLIENTE] ([Cliente_id], [Nombre], [Cedula], [Ciudad]) VALUES (8, N'Ronny', N'1234567897', N'Guayaquil')
INSERT [dbo].[CLIENTE] ([Cliente_id], [Nombre], [Cedula], [Ciudad]) VALUES (9, N'Raquel', N'1234567898', N'Cuenca')
SET IDENTITY_INSERT [dbo].[CLIENTE] OFF
GO
SET IDENTITY_INSERT [dbo].[FACTURA_CABECERA] ON 

INSERT [dbo].[FACTURA_CABECERA] ([Factura_cabecera_id], [Fecha], [Forma_pago_id], [Cliente_id]) VALUES (1, CAST(N'2026-01-01T00:00:00.000' AS DateTime), 5, 1)
INSERT [dbo].[FACTURA_CABECERA] ([Factura_cabecera_id], [Fecha], [Forma_pago_id], [Cliente_id]) VALUES (4, CAST(N'2026-01-12T00:00:00.000' AS DateTime), 4, 5)
INSERT [dbo].[FACTURA_CABECERA] ([Factura_cabecera_id], [Fecha], [Forma_pago_id], [Cliente_id]) VALUES (5, CAST(N'2025-12-24T00:00:00.000' AS DateTime), 3, 2)
INSERT [dbo].[FACTURA_CABECERA] ([Factura_cabecera_id], [Fecha], [Forma_pago_id], [Cliente_id]) VALUES (6, CAST(N'2025-11-03T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[FACTURA_CABECERA] ([Factura_cabecera_id], [Fecha], [Forma_pago_id], [Cliente_id]) VALUES (7, CAST(N'2025-10-02T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[FACTURA_CABECERA] ([Factura_cabecera_id], [Fecha], [Forma_pago_id], [Cliente_id]) VALUES (8, CAST(N'2025-10-03T00:00:00.000' AS DateTime), 3, 7)
SET IDENTITY_INSERT [dbo].[FACTURA_CABECERA] OFF
GO
SET IDENTITY_INSERT [dbo].[FACTURA_DETALLE] ON 

INSERT [dbo].[FACTURA_DETALLE] ([Factura_detalle_id], [Cantidad], [Precio], [Factura_cabecera_id], [Producto_id]) VALUES (1, CAST(1.00 AS Numeric(6, 2)), CAST(1.00 AS Decimal(6, 2)), 1, 1)
INSERT [dbo].[FACTURA_DETALLE] ([Factura_detalle_id], [Cantidad], [Precio], [Factura_cabecera_id], [Producto_id]) VALUES (4, CAST(1.00 AS Numeric(6, 2)), CAST(2.00 AS Decimal(6, 2)), 4, 4)
INSERT [dbo].[FACTURA_DETALLE] ([Factura_detalle_id], [Cantidad], [Precio], [Factura_cabecera_id], [Producto_id]) VALUES (5, CAST(2.00 AS Numeric(6, 2)), CAST(3.00 AS Decimal(6, 2)), 4, 5)
INSERT [dbo].[FACTURA_DETALLE] ([Factura_detalle_id], [Cantidad], [Precio], [Factura_cabecera_id], [Producto_id]) VALUES (6, CAST(3.00 AS Numeric(6, 2)), CAST(4.00 AS Decimal(6, 2)), 5, 6)
INSERT [dbo].[FACTURA_DETALLE] ([Factura_detalle_id], [Cantidad], [Precio], [Factura_cabecera_id], [Producto_id]) VALUES (7, CAST(4.00 AS Numeric(6, 2)), CAST(5.00 AS Decimal(6, 2)), 6, 7)
INSERT [dbo].[FACTURA_DETALLE] ([Factura_detalle_id], [Cantidad], [Precio], [Factura_cabecera_id], [Producto_id]) VALUES (8, CAST(5.00 AS Numeric(6, 2)), CAST(6.00 AS Decimal(6, 2)), 7, 8)
INSERT [dbo].[FACTURA_DETALLE] ([Factura_detalle_id], [Cantidad], [Precio], [Factura_cabecera_id], [Producto_id]) VALUES (11, CAST(2.00 AS Numeric(6, 2)), CAST(2.00 AS Decimal(6, 2)), 5, 2)
INSERT [dbo].[FACTURA_DETALLE] ([Factura_detalle_id], [Cantidad], [Precio], [Factura_cabecera_id], [Producto_id]) VALUES (13, CAST(3.00 AS Numeric(6, 2)), CAST(3.00 AS Decimal(6, 2)), 6, 3)
INSERT [dbo].[FACTURA_DETALLE] ([Factura_detalle_id], [Cantidad], [Precio], [Factura_cabecera_id], [Producto_id]) VALUES (14, CAST(4.00 AS Numeric(6, 2)), CAST(5.00 AS Decimal(6, 2)), 5, 6)
INSERT [dbo].[FACTURA_DETALLE] ([Factura_detalle_id], [Cantidad], [Precio], [Factura_cabecera_id], [Producto_id]) VALUES (16, CAST(1.00 AS Numeric(6, 2)), CAST(1.00 AS Decimal(6, 2)), 7, 2)
INSERT [dbo].[FACTURA_DETALLE] ([Factura_detalle_id], [Cantidad], [Precio], [Factura_cabecera_id], [Producto_id]) VALUES (17, CAST(2.00 AS Numeric(6, 2)), CAST(3.00 AS Decimal(6, 2)), 8, 3)
INSERT [dbo].[FACTURA_DETALLE] ([Factura_detalle_id], [Cantidad], [Precio], [Factura_cabecera_id], [Producto_id]) VALUES (19, CAST(4.00 AS Numeric(6, 2)), CAST(6.00 AS Decimal(6, 2)), 8, 8)
INSERT [dbo].[FACTURA_DETALLE] ([Factura_detalle_id], [Cantidad], [Precio], [Factura_cabecera_id], [Producto_id]) VALUES (20, CAST(5.00 AS Numeric(6, 2)), CAST(3.00 AS Decimal(6, 2)), 4, 8)
SET IDENTITY_INSERT [dbo].[FACTURA_DETALLE] OFF
GO
SET IDENTITY_INSERT [dbo].[FORMA_PAGO] ON 

INSERT [dbo].[FORMA_PAGO] ([Forma_pago_id], [Nombre]) VALUES (1, N'Efectivo')
INSERT [dbo].[FORMA_PAGO] ([Forma_pago_id], [Nombre]) VALUES (2, N'Transferencia')
INSERT [dbo].[FORMA_PAGO] ([Forma_pago_id], [Nombre]) VALUES (3, N'Tarjeta de Debito')
INSERT [dbo].[FORMA_PAGO] ([Forma_pago_id], [Nombre]) VALUES (4, N'Tarjeta de Credito')
INSERT [dbo].[FORMA_PAGO] ([Forma_pago_id], [Nombre]) VALUES (5, N'Cheque')
INSERT [dbo].[FORMA_PAGO] ([Forma_pago_id], [Nombre]) VALUES (6, N'De Una')
SET IDENTITY_INSERT [dbo].[FORMA_PAGO] OFF
GO
SET IDENTITY_INSERT [dbo].[PRODUCTO] ON 

INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (1, N'LECHE', N'LA VAQUITA', 1, 6)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (2, N'MANTEQUILLA', N'GONZALEZ', 1, 3)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (3, N'QUESO', N'AKI', 1, 7)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (4, N'CARNE', N'SUPERMAXI', 2, 1)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (5, N'CHULETA', N'AKI', 2, 7)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (6, N'POLLO', N'AKI', 3, 7)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (7, N'ALITAS', N'S/M', 3, 2)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (8, N'GASEOSA', N'COCA COLA', 4, 3)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (9, N'AGUA', N'GUITIG', 4, 4)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (10, N'SAL', N'S/M', 5, 2)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (11, N'AZUCAR', N'SAN CARLOS', 5, 6)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (12, N'ACEITE', N'LA FAVORITA', 5, 2)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (13, N'ESCOBA', N'S/M', 6, 1)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (14, N'JABON', N'ALES', 6, 2)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (15, N'DETERGENTE', N'DEJA', 6, 5)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (16, N'FRESAS', N'S/M', 7, 2)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (17, N'PLATANO', N'DOLE', 7, 1)
INSERT [dbo].[PRODUCTO] ([Producto_id], [Nombre], [Marca], [Categoria_id], [Proveedor_id]) VALUES (18, N'NARANJA', N'AKI', 7, 7)
SET IDENTITY_INSERT [dbo].[PRODUCTO] OFF
GO
SET IDENTITY_INSERT [dbo].[PROVEEDOR] ON 

INSERT [dbo].[PROVEEDOR] ([Proveedor_id], [Nombre], [Ruc]) VALUES (1, N'Supermaxi', N'123')
INSERT [dbo].[PROVEEDOR] ([Proveedor_id], [Nombre], [Ruc]) VALUES (2, N'Santa Maria', N'123')
INSERT [dbo].[PROVEEDOR] ([Proveedor_id], [Nombre], [Ruc]) VALUES (3, N'Megamaxi', N'123')
INSERT [dbo].[PROVEEDOR] ([Proveedor_id], [Nombre], [Ruc]) VALUES (4, N'Tia', N'123')
INSERT [dbo].[PROVEEDOR] ([Proveedor_id], [Nombre], [Ruc]) VALUES (5, N'Mi Comisariato', N'123')
INSERT [dbo].[PROVEEDOR] ([Proveedor_id], [Nombre], [Ruc]) VALUES (6, N'Tuti', N'123')
INSERT [dbo].[PROVEEDOR] ([Proveedor_id], [Nombre], [Ruc]) VALUES (7, N'Aki', N'123')
SET IDENTITY_INSERT [dbo].[PROVEEDOR] OFF
GO
ALTER TABLE [dbo].[FACTURA_CABECERA]  WITH CHECK ADD  CONSTRAINT [FK_FACTURA_CABECERA_Cliente_id] FOREIGN KEY([Cliente_id])
REFERENCES [dbo].[CLIENTE] ([Cliente_id])
GO
ALTER TABLE [dbo].[FACTURA_CABECERA] CHECK CONSTRAINT [FK_FACTURA_CABECERA_Cliente_id]
GO
ALTER TABLE [dbo].[FACTURA_CABECERA]  WITH CHECK ADD  CONSTRAINT [FK_FACTURA_CABECERA_Forma_pago_id] FOREIGN KEY([Forma_pago_id])
REFERENCES [dbo].[FORMA_PAGO] ([Forma_pago_id])
GO
ALTER TABLE [dbo].[FACTURA_CABECERA] CHECK CONSTRAINT [FK_FACTURA_CABECERA_Forma_pago_id]
GO
ALTER TABLE [dbo].[FACTURA_DETALLE]  WITH CHECK ADD  CONSTRAINT [FK_FACTURA_DETALLE_Factura_cabecera_id] FOREIGN KEY([Factura_cabecera_id])
REFERENCES [dbo].[FACTURA_CABECERA] ([Factura_cabecera_id])
GO
ALTER TABLE [dbo].[FACTURA_DETALLE] CHECK CONSTRAINT [FK_FACTURA_DETALLE_Factura_cabecera_id]
GO
ALTER TABLE [dbo].[FACTURA_DETALLE]  WITH CHECK ADD  CONSTRAINT [FK_FACTURA_DETALLE_Producto_id] FOREIGN KEY([Producto_id])
REFERENCES [dbo].[PRODUCTO] ([Producto_id])
GO
ALTER TABLE [dbo].[FACTURA_DETALLE] CHECK CONSTRAINT [FK_FACTURA_DETALLE_Producto_id]
GO
ALTER TABLE [dbo].[PRODUCTO]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCTO_Categoria_id] FOREIGN KEY([Categoria_id])
REFERENCES [dbo].[CATEGORIA] ([Categoria_id])
GO
ALTER TABLE [dbo].[PRODUCTO] CHECK CONSTRAINT [FK_PRODUCTO_Categoria_id]
GO
ALTER TABLE [dbo].[PRODUCTO]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCTO_Proveedor_id] FOREIGN KEY([Proveedor_id])
REFERENCES [dbo].[PROVEEDOR] ([Proveedor_id])
GO
ALTER TABLE [dbo].[PRODUCTO] CHECK CONSTRAINT [FK_PRODUCTO_Proveedor_id]
GO
