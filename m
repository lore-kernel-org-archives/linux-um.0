Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FWV6a-0004jj-Qe for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Apr 2006 02:05:40 -0700
Received: from mtagate1.de.ibm.com ([195.212.29.150])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FWV6Z-0003GP-9k
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Apr 2006 02:05:40 -0700
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.6/8.13.6) with ESMTP id k3K95QsW135402
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 20 Apr 2006 09:05:26 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3K96QZI114200 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 20 Apr 2006 11:06:26 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3K95PgD009954 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 20 Apr 2006 11:05:25 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20060420090514.GA9452@osiris.boeblingen.de.ibm.com>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 20 Apr 2006 11:05:14 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> Add PTRACE_SYSCALL_MASK, which allows system calls to be selectively
> traced.  It takes a bitmask and a length.  A system call is traced
> if its bit is one.  Otherwise, it executes normally, and is
> invisible to the ptracing parent.
> [...]
> +int set_syscall_mask(struct task_struct *child, char __user *mask,
> +		     unsigned long len)
> +{
> +	int i, n = (NR_syscalls + 7) / 8;
> +	char c;
> +
> +	if(len > n){
> +		for(i = NR_syscalls; i < len * 8; i++){
> +			get_user(c, &mask[i / 8]);
> +			if(!(c & (1 << (i % 8)))){
> +				printk("Out of range syscall at %d\n", i);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		len = n;
> +	}

Since it's quite likely that len > n will be true (e.g. after installing the
latest version of your debug tool) it would be better to silently ignore all
bits not within the range of NR_syscalls.
There is no point in flooding the console. The tracing process won't see any
of the non existant syscalls it requested to see anyway.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
