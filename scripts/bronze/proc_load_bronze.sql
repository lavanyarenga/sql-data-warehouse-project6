create or alter procedure bronze.load_bronze as 
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	set @batch_start_time= getdate();
	print '=========================================';
	print 'Loading the bronze layer CRM';
	print '=========================================';

	set  @start_time = getdate();
	print '>> truncating the crm_cust_info table'
	truncate table bronze.crm_cust_info;

	BULK INSERT bronze.crm_cust_info
			FROM 'C:\Users\lrenganathan\Documents\SQL Practice\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

	--select count(*) from bronze.crm_cust_info
	set  @end_time = getdate();
	print '>> load duration: ' + cast (datediff(second, @start_time, @end_time) as nvarchar) + 'second';

	set  @start_time = getdate();
	print '>> truncating the crm_prd_info table';
	truncate table bronze.crm_prd_info;

	BULK INSERT bronze.crm_prd_info
			FROM 'C:\Users\lrenganathan\Documents\SQL Practice\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

	--select count(*) from bronze.crm_prd_info
	set  @end_time = getdate();
	print '>> load duration: ' + cast (datediff(second, @start_time, @end_time) as nvarchar) + 'second';

	set  @start_time = getdate();
	print '>> truncating the crm_sales_details table'
	truncate table bronze.crm_sales_details;

	BULK INSERT bronze.crm_sales_details
			FROM 'C:\Users\lrenganathan\Documents\SQL Practice\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

	--select count(*) from bronze.crm_sales_details
	set  @end_time = getdate();
	print '>> load duration: ' + cast (datediff(second, @start_time, @end_time) as nvarchar) + 'second';

	print '=========================================';
	print 'Loading the bronze layer ERP';
	print '=========================================';

	set  @start_time = getdate();
	print '>> truncating the erp_cust_az12 table'
	truncate table bronze.erp_cust_az12;

	BULK INSERT bronze.erp_cust_az12
			FROM 'C:\Users\lrenganathan\Documents\SQL Practice\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

	--select count(*) from bronze.erp_cust_az12
	set  @end_time = getdate();
	print '>> load duration: ' + cast (datediff(second, @start_time, @end_time) as nvarchar) + 'second';

	print '>> truncating the erp_LOC_A101 table'
	truncate table bronze.erp_LOC_A101;
	BULK INSERT bronze.erp_LOC_A101
			FROM 'C:\Users\lrenganathan\Documents\SQL Practice\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

	--select count(*) from bronze.erp_LOC_A101

	print '>> truncating the erp_PX_CAT_G1V2'
	truncate table bronze.erp_PX_CAT_G1V2;
	BULK INSERT bronze.erp_PX_CAT_G1V2
			FROM 'C:\Users\lrenganathan\Documents\SQL Practice\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

	--select count(*) from bronze.erp_PX_CAT_G1V2
	set @batch_end_time = getdate();
	print 'totel load of thi batch' + cast(datediff(second, @batch_start_time,@batch_end_time)as nvarchar) + ' seconds';
end

exec bronze.load_bronze
