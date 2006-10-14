Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GYYCC-0002VT-3Y for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 18:20:12 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GYYCA-0007sa-Mq
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 18:20:12 -0700
Message-ID: <45303B3C.808@theshore.net>
Date: Fri, 13 Oct 2006 20:19:56 -0500
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
References: <452C29F2.8050908@theshore.net>
	<20061013200747.GB5517@ccure.user-mode-linux.org>
	<200610140243.00086.blaisorblade@yahoo.it>
In-Reply-To: <200610140243.00086.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x92c00000, ip 0x80bcead
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> On Friday 13 October 2006 22:07, Jeff Dike wrote:
>> On Tue, Oct 10, 2006 at 06:17:06PM -0500, Christopher S. Aker wrote:
>>> This is 2.6.18-um, on top of a 2.6.16.29-skas3-v8.2 host.
>>>
>>> Kernel file is here:
>>> http://www.theshore.net/~caker/uml/kernels/2.6.18-linode25
>>>
>>>
>>> Kernel panic - not syncing: Kernel mode fault at addr 0x92c00000, ip
>>> 0x80bcead
> Jeff, are these addresses normal? They tell that the binary is a statically 
> linked one - but what is the memory layout? Chris, can you post 
> cat /proc/<pid>/maps on a running instance of that kernel, together with host 
> and guest config (the guest's one is contained there, I know, but I don't 
> have the time to extract).
> 
> I'm suspiscious about memory layout problems (say host with unusual splits, 
> like 1G/3G, or some problem with memory mappings anyhow).

All the stuff you requested is in here: 
http://www.theshore.net/~caker/uml/kmf/

http://www.theshore.net/~caker/uml/kmf/maps.txt (has the maps from all 
the UML's pids, in case you notice duplicates)

http://www.theshore.net/~caker/uml/kmf/config-2.6.18-um.txt
http://www.theshore.net/~caker/uml/kmf/config-2.6.16.29-1-bigmem-skas-v8.2.txt

Thanks!
-Chris


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
