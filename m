Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhoGJ-0002L5-Oq for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 03:05:07 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AhoGJ-0007RZ-7Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 03:05:07 -0800
References: <4008A7DF.6000308@lig.net>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <4008A7DF.6000308@lig.net>
Message-ID: <87llo6hmmc.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: What is the most up to date,
	least crashing kernel+patch?
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
Date: 17 Jan 2004 11:53:47 +0100
To: "Stephen D. Williams" <sdw@lig.net>, user-mode-linux-devel@lists.sourceforge.net

"Stephen D. Williams" <sdw@lig.net> writes:

> I would like 2.6.1 as a UML kernel along with support for >512 UML ram
> and preferrably modules.  What is the best I can get right now?
> 
> I'm running Gerd/SuSE's 2.6.0-test9,

ftp://ftp.suse.com/pub/people/kraxel/i386/ has 2.6.1 rpms since a few
hours.  Both binary and source rpms, both uml and host, host with
skas3, all building out a single source tree.  Modules don't work yet
through.

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
