Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbNel-0006rl-9I for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jun 2004 11:00:03 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BbNek-0004vU-If for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jun 2004 11:00:02 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: SKAS patch (was: Re: [uml-devel] uml memory leak)
References: <200405221708.45574.linux@1g6.biz>
In-Reply-To: <200405221708.45574.linux@1g6.biz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406182010.24658.blaisorblade_spam@yahoo.it>
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
Date: Fri, 18 Jun 2004 20:10:24 +0200
To: Nicolas <linux@1g6.biz>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Alle 17:08, sabato 22 maggio 2004, Nicolas ha scritto:
> Hello,
>
> Here is my hostos config :
>
> fresh 2.6.6 kernel with :
>
> uml-patch-2.6.6-02
> patch-2.6.6-v2
> host+Uml-skas3-2.6.6-v1.patch
>
> I noticed a memory leak each time starting/stopping
> an uml os. (approx 7mo).

I resume his datas:
Before:
size-4096          17898  17898   4096    1    1 : tunables   24   12    0 : 
slabdata  17898  17898      0
size-32            20157  20679     32  113    1 : tunables  120   60    0 : 
slabdata    183    183      0

After starting and stopping 10 UMLs:
size-4096          37539  37539   4096    1    1 : tunables   24   12    0 : 
slabdata  37539  37539      0
size-32            39791  40228     32  113    1 : tunables  120   60    0 : 
slabdata    356    356      0

> I don't know what it means, but size-32 and size-4096 are increasing ...

I can confirm it on 2.4.26 with the SKAS patch I prepared (which is VERY 
similar to the 2.6 one), and preemption + O(1) scheduler (actually, the whole 
-lck tree).

Sadly I did not save my /proc/meminfo before rebooting, but I just found about 
256M leaked by the host, after running multiple UML in skas mode. I expect 
this not to happen in TT mode (this is probably a bug in the SKAS patch).

There were about 64*1000 objects inside size-4096 (i.e. each one wasting 4k), 
and notably about the same number of objects inside size-32 (i.e. we leak 
this things together). Btw, I went down to runlevel 1 and those objects were 
still there. So it's a kernel leak. It is not a mm_struct leak, so I don't 
understand where it comes from.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
