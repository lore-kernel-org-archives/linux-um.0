Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FIX6A-0003ZT-T3 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Mar 2006 12:23:30 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FIX66-0001XY-VW
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Mar 2006 12:23:30 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Occasional hang starting up.
References: <200603111301.42195.rob@landley.net>
In-Reply-To: <200603111301.42195.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603122133.01361.blaisorblade@yahoo.it>
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
Date: Sun, 12 Mar 2006 21:33:00 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Saturday 11 March 2006 19:01, Rob Landley wrote:
> On linux-2.6.16-rc5 I'm occasionally getting a hang starting up (with
> rootfstype=hostfs), right after the initializing VFS line.  This time when
> I killed it, I got the following error (repeated twice):
>
> remove_umid_dir - actually_do_remove failed with err = -2

> I'm guessing that's where it's hanging?

I guess not.
That's a shutdown function - when UML exits it should remove ~/.uml/<umid> and 
contained files.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
