Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRFPt-0000JW-5v	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 13:15:21 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DRFPo-0000jj-Hm	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 13:15:21 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML Kernel support for NPTL
References: <29D15BBCA340DA4D8146D38B4924FC7A104FD6@zcarhxm0.corp.nortel.com>
In-Reply-To: <29D15BBCA340DA4D8146D38B4924FC7A104FD6@zcarhxm0.corp.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504292323.15454.blaisorblade@yahoo.it>
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
Date: Fri, 29 Apr 2005 23:23:15 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Majid Salame <msalame@nortel.com>

On Thursday 28 April 2005 21:17, Majid Salame wrote:
> Hi,
>
> Did anyone implement the UML kernel support  for the NPTL thread library?
> Or specifically implemented the set_thread_area system call in UML.

> I am interested to boot UML with a rootfs with packages built with a
> version of glibc that was compiled with Native POSIX Thread Library (NPTL)
> support.

> Thanks.
> Majid.
Well, I've started working on this, even if this does not still work. The code 
is fairly complete, I hope I can finish it within two weeks.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
