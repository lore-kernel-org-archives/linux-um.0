Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BEObm-0005ii-C1 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Apr 2004 01:21:58 -0700
Received: from mx15.sac.fedex.com ([199.81.195.17])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BEObk-0008DK-SH
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Apr 2004 01:21:57 -0700
Received: from inet03.prod.fedex.com (inet03.prod.fedex.com [199.81.10.43])
	by mx15.sac.fedex.com (8.12.9p2/8.12.9) with ESMTP id i3G8LfGd013905
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 16 Apr 2004 03:21:41 -0500 (CDT)
	(envelope-from jeff98@silk.corp.fedex.com)
Received: from entpm11.apac.fedex.com (entpm11.apac.fedex.com [155.161.92.11])
	by inet03.prod.fedex.com (8.12.11/8.12.11) with ESMTP id
	i3G8Ld8a000820 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 16 Apr 2004 03:21:40 -0500 (CDT)
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Subject: Re: [uml-devel] Problems with the SKAS patch and 2.6
In-Reply-To: <407F7EFF.5060106@austin.rr.com>
Message-ID: <Pine.LNX.4.58.0404161608350.9658@boston.corp.fedex.com>
References: <407F7EFF.5060106@austin.rr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1436359237-1082103559=:9658"
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
Date: Fri, 16 Apr 2004 16:19:19 +0800 (SGT)
To: Steven Elliott <selliott4@austin.rr.com>
Cc: User Mode Linux Devel <user-mode-linux-devel@lists.sourceforge.net>



--0-1436359237-1082103559=:9658
Content-Type: TEXT/PLAIN; charset=US-ASCII


It is possible to run SKAS on 2.6. I'm running 2.6.6-rc1-1um SKAS now.

Try the attached patch (00-2.6.6-v0-host-SKAS2.patch.bz2) for 2.6.6-rc1.
It's slightly modified from the original 00-2.6.2-v1-host-SKAS2.patch.bz2
patch, which should apply up to 2.6.5.

Up to 2.6.5, the uml kernel should compile fine, but to compile 2.6.6-rc1,
those files in arch/um/util need to be modified. I'll try to post those
modifications if you're interested. Currently, I just simply modified
those files to get the kernel to compile, and need to go back to trace the
changes.

Thanks,
Jeff


On Fri, 16 Apr 2004, Steven Elliott wrote:

> I'd like to first thank you for creating a very valuable kernel
> debugging tool.  I wish more people knew about UML as a means of
> learning about how kernels work.
>
> I may be overlooking something, but as far as I can tell it is not
> currently possible to apply any of the SKAS patches to 2.6.
>
> The host-skas3.patch patch has several conflicts when applied to 2.6.  I
> attempted to manually port host-skas3.patch to 2.6, but I ran into a
> missing file or function (unfortunately I can remember what it was).
>
> Also, it is not obvious what host-skas-2.6.0-test1.diff should be
> applied to.  It seems to somehow depend on code added by the
> host-skas3.patch patch, but first applying the host-skas3.patch patch is
> not sufficient.  If someone could regenerate host-skas-2.6.0-test1.diff
> such that it can be applied to a straight 2.6 kernel that would be very
> helpful.
>
> Right now I'll assume that there are some technical problems with
> porting SKAS to 2.6, so it is not just a simple matter of shuffling code
> from the host-skas3.patch patch to the corresponding place in 2.6.
>
> Also, my experience has been that debugging with GDB works better when
> SKAS mode is used.  So, you might want to mention that in either the
> SKAS page or the debugging page.
>
> --
> -----------------------------------------------------------------------
> |          Steven Elliott          |      selliott4@austin.rr.com     |
> -----------------------------------------------------------------------
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>
--0-1436359237-1082103559=:9658
Content-Type: APPLICATION/octet-stream; name="00-2.6.6-v0-host-SKAS2.patch.bz2"
Content-ID: <Pine.LNX.4.58.0404161619190.9658@boston.corp.fedex.com>
Content-Description: 
Content-Disposition: attachment; filename="00-2.6.6-v0-host-SKAS2.patch.bz2"
Content-Transfer-Encoding: base64

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
XnIHMGVKMErK2lSnzEnnJMPtF3JFOFCQzQOScA==

--0-1436359237-1082103559=:9658--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
