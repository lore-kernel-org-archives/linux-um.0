Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj3Ro-0005gZ-EG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 13:30:08 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1Aj3Rn-0000Cx-QX
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 13:30:08 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
Message-ID: <20040120213040.GC25314@bytesex.org>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<200401172009.50449.blaisorblade_spam@yahoo.it>
	<87vfn7yikh.fsf@bytesex.org>
	<200401202042.17851.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401202042.17851.blaisorblade_spam@yahoo.it>
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
Date: Tue, 20 Jan 2004 22:30:40 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> > G-02-LinkScriptCleanup.patch removes various ksymtab stuff from
> > common.lds.S (which is in the RODATA #define these days), that one
> > looks like it could be needed too to make modules work ...
> 
> Those repeated sections are harmless, only ugly;

No: removing those sections made modules work for me. (behaviour may
depend on the binutils version through ...).

  Gerd

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
