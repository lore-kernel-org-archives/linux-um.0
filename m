Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlqDP-0003Fh-VL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jun 2006 09:40:07 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FlqDM-0000gu-E8
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jun 2006 09:40:08 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [NEWBYE]
References: <b921df970606010909v1081701vfe0168245d6ce728@mail.gmail.com>
In-Reply-To: <b921df970606010909v1081701vfe0168245d6ce728@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606011839.09644.blaisorblade@yahoo.it>
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
Date: Thu, 1 Jun 2006 18:39:09 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alessandro Corradi <ale.corradi@gmail.com>

On Thursday 01 June 2006 18:09, Alessandro Corradi wrote:
> Hi to everyboby,
> I'm preparing the degree's thesis about uml. I'm searching about device
> forwarding, eg. HOST->ttyS0 <---> UML->ttyS0
> I must see how this connection works. Then I must to handle it for
> remapping a virtual device in the host.
> Can you recommend me where is the right code to look up? (or a initial
> trace)
> Thanks
You should add to the initial uml command line something like 
"ssl0=tty:/dev/ttyS0", where ssl0 means "Uml first serial line" and after = 
you have the same syntax as for UML consoles.

You can find all details on:

http://user-mode-linux.sourceforge.net/input.html
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
