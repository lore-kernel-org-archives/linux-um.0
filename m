Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjzCx-0002Wq-UI for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 03:10:39 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AjzCx-0004Xd-Bk
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 03:10:39 -0800
References: <20040122114858.GH11029@bytesex.org>
	<20040122230626.GI17709@shell.blacknet.de>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <20040122230626.GI17709@shell.blacknet.de>
Message-ID: <87isj3uee3.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: [Sebastian.Koch@metatool.de: Re: ps u failed with
	signal 8 (FPE)]
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
Date: 23 Jan 2004 11:51:16 +0100
To: Goetz Bock <bock+uml@blacknet.de>, user-mode-linux-devel@lists.sourceforge.net

Goetz Bock <bock+uml@blacknet.de> writes:

> On Thu, Jan 22 '04 at 12:48, Gerd Knorr wrote:
> > "ps u" doesn't work in uml due to some values in /proc/meminfo being zero,
> > see below for details,
> Works fine here:

> user@uml ~$ cat /proc/version
> Linux version 2.4.22-4bgstatic-6um (root@basel1.hfz.info) (gcc version 3.3) #1 Mon Dec 1 01:18:56 CET 2003

The kernel in question is 2.6.x ...

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
