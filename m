Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhcAM-0005yr-5h for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2004 14:10:10 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AhcAL-0000Hd-Iz
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2004 14:10:09 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
Message-ID: <20040116215613.GA2849@bytesex.org>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<Pine.GSO.4.58.0401160957210.23807@algedi.dur.ac.uk>
	<200401161727.i0GHRKVW002726@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401161727.i0GHRKVW002726@ccure.user-mode-linux.org>
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
Date: Fri, 16 Jan 2004 22:56:13 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: M A Young <m.a.young@durham.ac.uk>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Jan 16, 2004 at 12:27:20PM -0500, Jeff Dike wrote:
> m.a.young@durham.ac.uk said:
> > Actually, I am no longer convinced the lack of these syscalls cause
> > the problem directly; I think there is something else in recent glibcs
> > that cause the kernel to hang, at least in tt mode, though it is
> > probably related. 
> 
> Maybe, but it's a definite problem.  However, the segfaults people were seeing
> with 2.6.1 may be gone since that was a separate problem which is fixed in
> the 2.6.1 patch.

The segfaults are gone for me, 2.6.1 with the new uml patch boots just fine.

  Gerd

PS: I've just pushed fresh-built kernel rpms, they should find their way
    to ftp.suse.com + mirrors (/pub/people/kraxel) next hours.

-- 
"... und auch das ganze Wochenende oll" -- Wetterbericht auf RadioEins


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
