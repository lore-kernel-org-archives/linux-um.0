Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7EQn-0002fF-Rg for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Mar 2005 07:09:33 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D7EQj-0001y2-Kc for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Mar 2005 07:09:33 -0800
Message-ID: <422879DE.6050405@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] 2.6.11 + uml.sf.net patches panic
References: <42267C13.1060703@rimuhosting.com>
	<200503031853.j23IrNDS003496@ccure.user-mode-linux.org>
	<42286F4A.30506@fujitsu-siemens.com>
In-Reply-To: <42286F4A.30506@fujitsu-siemens.com>
Content-Type: multipart/mixed; boundary="------------070503090402040009030207"
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
Date: Fri, 04 Mar 2005 16:08:14 +0100
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Peter <p.repliesignored@rimuhosting.com>

This is a multi-part message in MIME format.
--------------070503090402040009030207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bodo Stroesser wrote:
> Jeff Dike wrote:
> 
>> The write_ldt just above the segfault in both stacks looks suspicious.
> 
> 
> Yes. There seems to be a problem with this new stuff.
> 
> Peter, could you please send a full call trace? I guess, the ones in your
> mail are truncated, right?
> 
>           Bodo
Meanwhile I found a problem in arch/um/sys-i386/ldt.c, which causes UML
to panic, if LDT-entry number 8 is written, using modify_ldt-syscall.

This crash is very similar to the one Peter had, so I hope the appended
oneliner will solve the problem.

        Bodo

--------------070503090402040009030207
Content-Type: text/x-diff;
 name="fix-skas-ldt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-skas-ldt.patch"



---


diff -puN arch/um/sys-i386/ldt.c~fix-skas-ldt arch/um/sys-i386/ldt.c
--- linux-2.6.11-rc3-mm2/arch/um/sys-i386/ldt.c~fix-skas-ldt	2005-03-04 15:51:04.000000000 +0100
+++ linux-2.6.11-rc3-mm2-root/arch/um/sys-i386/ldt.c	2005-03-04 15:51:27.000000000 +0100
@@ -208,7 +208,7 @@ static int write_ldt(void __user * ptr, 
 		goto out_unlock;
 
 	if(ldt_info.entry_number >= ldt->entry_count &&
-	   ldt_info.entry_number > LDT_DIRECT_ENTRIES){
+	   ldt_info.entry_number >= LDT_DIRECT_ENTRIES){
 		for(i=ldt->entry_count/LDT_ENTRIES_PER_PAGE;
 		    i*LDT_ENTRIES_PER_PAGE <= ldt_info.entry_number;
 		    i++){
_

--------------070503090402040009030207--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
