Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AeHYI-0008Ts-Tv for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jan 2004 09:33:06 -0800
Received: from mx11.sac.fedex.com ([199.81.193.118])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AeHYI-0004dN-FM
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jan 2004 09:33:06 -0800
Received: from inet04.prod.fedex.com (inet04.prod.fedex.com [199.81.10.44])
	by mx11.sac.fedex.com (8.12.6p2/8.12.3) with ESMTP id i07HX3iC068696
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 7 Jan 2004 11:33:03 -0600 (CST) (envelope-from jchua@fedex.com)
From: Jeff Chua <jchua@fedex.com>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip0x400e51a4
In-Reply-To: <a06020411bc214f56bc9e@[192.168.1.10]>
Message-ID: <Pine.LNX.4.58.0401080110070.28164@boston.corp.fedex.com>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com><200401061718.i
	06HILtd002620@ccure.user-mode-linux.org><a0602040abc20a9f6862e@[192.16
	8.1.10]><200401061918.31447.blaisorblade_spam@yahoo.it>     
	<a0602040bbc20b325acfd@[192.168.1.10]>
	<33261.193.212.97.12.1073406789.squirrel@pluto.nixia.no>
	<a0602040cbc20b788b425@[192.168.1.10]>
	<a0602040dbc20be564c59@[192.168.1.10]>
	<Pine.LNX.4.58.0401070325360.1840@boston.corp.fedex.com>
	<a0602040ebc20d1fee774@[192.168.1.10]>
	<Pine.LNX.4.58.0401070444370.1840@boston.corp.fedex.com>
	<a0602040fbc20d995ae8b@[192.168.1.10]>
	<Pine.LNX.4.58.0401070529520.1840@boston.corp.fedex.com>
	<a06020410bc20df3e0219@[192.168.1.10]>
	<Pine.LNX.4.58.0401070537580.1840@boston.corp.fedex.com>
	<a06020411bc214f56bc9e@[192.168.1.10]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 8 Jan 2004 01:10:58 +0800 (SGT)
To: Johannes Formann <johannes@formann.de>
Cc: Jeff Chua <jchua@fedex.com>, Jeff Chua <jeff98@silk.corp.fedex.com>, UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>


On Wed, 7 Jan 2004, Johannes Formann wrote:

> At 5:39 Uhr +0800 07.01.2004, Jeff Chua wrote:
> >On Tue, 6 Jan 2004, Johannes Formann wrote:
> >
> >>  At 5:32 Uhr +0800 07.01.2004, Jeff Chua wrote:
> >>
> >>  Well, than this patch does not fix the bug.
> >
> >Send me your .config.
>
> Is on the way.


That looks like a 2.6 kernel. The fix was for 2.4.

I'll try it out. Are you using lvm?

Thanks,
Jeff



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
