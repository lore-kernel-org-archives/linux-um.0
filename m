Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ds6ws-0002Dj-TG	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 15:40:26 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.44)
	id 1Ds6wo-0002qc-Et	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 15:40:27 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050709110143.D59181E9EA4@zion.home.lan>
	<200507120020.52418.blaisorblade@yahoo.it> <42D2F22C.3060102@rimuhosting.com>
In-Reply-To: <42D2F22C.3060102@rimuhosting.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507120047.33064.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: unregister_netdevice: waiting for tap24 to become
	free
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
Date: Tue, 12 Jul 2005 00:47:32 +0200
To: Peter <peter.spamcatcher@rimuhosting.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tuesday 12 July 2005 00:26, Peter wrote:
> Nothing in the logs prior to the first error message.
>
> I've hit this before at different times on other servers.  If there are
> some commands I can run to gather more diagnostics on the problem,
> please let me know and I'll capture more information next time.
>
> I see the error was reported with older 2.6 kernels and a patch was
> floating around.  I'm not sure if that is integrated into the current
> 2.6.11 kernel.
The patch named there has been integrated, verifyable at 
http://linux.bkbits.net:8080/linux-2.6/cset@4129735fMSVl0_RA4uNcNBWHFjT-zw

However this time the bug is probably due to something entirely different, the 
message is not very specific.

Tried 2.6.12? SKAS has been already updated (plus there's an important update 
for SKAS, from -V8 to -V8.2).
> http://www.google.com/search?q=unregister_netdevice%3A+waiting
>
> Regards, Peter

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
