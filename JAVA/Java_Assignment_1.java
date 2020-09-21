package Entity;

import java.time.LocalDate;

public class Java_Assignment_1 {
	public static void main(String[] args) {
		
		// add values in Department
		Department developmentDepartment = new Department();
		developmentDepartment.departmentID = 1;
		developmentDepartment.departmentName = "Development";
		
		Department saleDepartment = new Department();
		saleDepartment.departmentID = 2;
		saleDepartment.departmentName = "Sale";
		
		// add values in Position
		Position baPosition = new Position();
		baPosition.positionID = 1;
		baPosition.positionName = "BA";
		
		Position saleSupportPosition = new Position();
		saleSupportPosition.positionID = 2;
		saleSupportPosition.positionName = "PM";
		
		Position developerPosition = new Position();
		developerPosition.positionID = 1;
		developerPosition.positionName = "Developer";
		
		// add values in Account
		Account NhungAccount = new Account();
		NhungAccount.accountID = 1;
		NhungAccount.userName = "nhung.tongthi";
		NhungAccount.fullName = "Tong Thi Nhung";
		NhungAccount.gender = Gender.FEMALE;
		NhungAccount.department = developmentDepartment;
		NhungAccount.position = baPosition;
		NhungAccount.email = "nhung.tongthi@vti.com.vn";
		
		Account HoangAccount = new Account();
		HoangAccount.accountID = 2;
		HoangAccount.userName = "hoang.dinhminh";
		HoangAccount.fullName = "Dinh Minh Hoang";
		HoangAccount.gender = Gender.MALE;
		HoangAccount.department = developmentDepartment;
		HoangAccount.position = baPosition;
		HoangAccount.email = "hoang.dinhminh@vti.com.vn";
				
		Account TrungAccount = new Account();
		TrungAccount.accountID = 3;
		TrungAccount.userName = "trung.phamdinh";
		TrungAccount.fullName = "Pham Dinh Trung";
		TrungAccount.gender = Gender.MALE;
		TrungAccount.department = developmentDepartment;
		TrungAccount.position = baPosition;
		TrungAccount.email = "trung.phamdinh@vti.com.vn";
		
		Account QuanAccount = new Account();
		QuanAccount.accountID = 4;
		QuanAccount.userName = "quan.nguyentrung";
		QuanAccount.fullName = "Nguyen Trung Quan";
		QuanAccount.gender = Gender.MALE;
		QuanAccount.department = saleDepartment;
		QuanAccount.position = saleSupportPosition;
		QuanAccount.email = "quan.nguyentrung@vti.com.vn";
		
		// add values in group
		Group BAgroup = new Group();
		BAgroup.groupID = 1;
		BAgroup.groupName = "BAGroup";
		BAgroup.createDate = LocalDate.of(2019, 07, 01);
		
		Group SaleGroup = new Group();
		SaleGroup.groupID = 2;
		SaleGroup.groupName = "SaleGroup";
		SaleGroup.createDate = LocalDate.of(2019, 04, 20);
		
		Group DevGroup = new Group();
		DevGroup.groupID = 3;
		DevGroup.groupName = "DevGroup";
		DevGroup.createDate = LocalDate.of(2019, 06, 10);
		
		// add values in GroupAccount		
		GroupAccount groupAccount1 = new GroupAccount();
		groupAccount1.group = BAgroup;
		groupAccount1.account = NhungAccount;
		groupAccount1.joinDate = LocalDate.of(2019, 07, 01);
		
		GroupAccount groupAccount2 = new GroupAccount();
		groupAccount2.group = BAgroup;
		groupAccount2.account = TrungAccount;
		groupAccount2.joinDate = LocalDate.of(2019, 10, 11);
		
		GroupAccount groupAccount3 = new GroupAccount();
		groupAccount3.group = DevGroup;
		groupAccount3.account = HoangAccount;
		groupAccount3.joinDate = LocalDate.of(2019, 6, 11);
		
		GroupAccount groupAccount4 = new GroupAccount();
		groupAccount4.group = SaleGroup;
		groupAccount4.account = QuanAccount;
		groupAccount4.joinDate = LocalDate.of(2019, 4, 30);
		
		GroupAccount groupAccount5 = new GroupAccount();
		groupAccount5.group = DevGroup;
		groupAccount5.account = NhungAccount;
		groupAccount5.joinDate = LocalDate.of(2020, 01, 20);
		
		// add account to department
		Account[] accounts = {NhungAccount, HoangAccount,TrungAccount};
		developmentDepartment.accounts = accounts;
		
		// accounts join the same group
		GroupAccount[] groupAccounts1 = {groupAccount1,groupAccount2};
		BAgroup.accounts = groupAccounts1;
		
		// all of groups of account
		GroupAccount[] groupAccounts2 = {groupAccount1, groupAccount5};
		NhungAccount.groups = groupAccounts2;
		
		
		// print department
		System.out.println("Thong tin user: " + NhungAccount.fullName);
		System.out.println("Phong ban: " + NhungAccount.department.departmentName);
		System.out.println("Thong tin chuc vu: " + NhungAccount.position.positionName);
		
		// print group
		for (GroupAccount groupAccount : BAgroup.accounts) {
			System.out.println(groupAccount.account.fullName);
			System.out.println("Ngay join Group: " + groupAccount.joinDate);
			System.out.println(groupAccount.account.position.positionName);
			System.out.println(groupAccount.account.department.departmentName);		
			
			}

	}
}


