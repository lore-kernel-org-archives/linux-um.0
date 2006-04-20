Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FWZyY-0005Sm-Ue for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Apr 2006 07:17:42 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FWZyY-0004SB-Gr
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Apr 2006 07:17:42 -0700
Message-ID: <444797F8.6020509@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<20060420090514.GA9452@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060420090514.GA9452@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Thu, 20 Apr 2006 16:17:28 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Heiko Carstens wrote:
>>Add PTRACE_SYSCALL_MASK, which allows system calls to be selectively
>>traced.  It takes a bitmask and a length.  A system call is traced
>>if its bit is one.  Otherwise, it executes normally, and is
>>invisible to the ptracing parent.
>>[...]
>>+int set_syscall_mask(struct task_struct *child, char __user *mask,
>>+		     unsigned long len)
>>+{
>>+	int i, n = (NR_syscalls + 7) / 8;
>>+	char c;
>>+
>>+	if(len > n){
>>+		for(i = NR_syscalls; i < len * 8; i++){
>>+			get_user(c, &mask[i / 8]);
>>+			if(!(c & (1 << (i % 8)))){
>>+				printk("Out of range syscall at %d\n", i);
>>+				return -EINVAL;
>>+			}
>>+		}
>>+
>>+		len = n;
>>+	}
> 
> 
> Since it's quite likely that len > n will be true (e.g. after installing the
> latest version of your debug tool) it would be better to silently ignore all
> bits not within the range of NR_syscalls.
> There is no point in flooding the console. The tracing process won't see any
> of the non existant syscalls it requested to see anyway.

Shouldn't 'len' better be the number of bits in the mask than the number of chars?
Assume a syscall newly added to UML would be a candidate for processing on the host,
but the incremented NR_syscalls still would result in the same number of bytes. Also
assume, host doesn't yet have that new syscall. Current implementation doesn't catch
the fact, that host can't execute that syscall.

OTOH, I think UML shouldn't send the entire mask, but relevant part only. The missing
end is filled with 0xff by host anyway. So it would be enough to send the mask up to the
highest bit representing a syscall, that needs to be executed by host. (currently, that
is __NR_gettimeofday). If UML would do so, no more problem results from UML having
a higher NR_syscall than the host (as long as the new syscalls are to be intercepted
and executed by UML)

A greater problem might be a process in UML, that calls an invalid syscall number. AFAICS
syscall number (orig_eax) isn't checked before it is used in do_syscall_trace to address
syscall_mask. This might result in a crash.

Bodo


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
