Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRFU8-0000Rq-0n	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 13:19:44 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DRFU6-00019H-BO	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 13:19:43 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Question about kernel_thread in UML TT mode
References: <000b01c54bd9$24d32150$90b3c68a@SHZ.ST.COM>
In-Reply-To: <000b01c54bd9$24d32150$90b3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504292220.48040.blaisorblade@yahoo.it>
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
Date: Fri, 29 Apr 2005 22:20:47 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alex LIU <alex.liu@st.com>

On Thursday 28 April 2005 12:00, Alex LIU wrote:
> Hi,all:
>
> I found UML only implement its own kernel_thread function but doesn't
> implement kernel_thread_helper function.
??? What's kernel_thread_helper? kernel_thread calls the arch-independent 
do_fork(), which works like the rest. In particular, it will call the 
arch-specific copy_thread; and copy_thread_tt will do the necessary work.
> Then how does UML start a kernel 
> thread in TT mode? Is there any other functions being called? Thanks a lot!

> Alex

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
