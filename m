Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbzKK-0002Uu-6l	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 May 2005 04:18:00 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DbzKE-0004Fk-QE	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 May 2005 04:17:59 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <200505270306.09425.blaisorblade@yahoo.it>
	<20050527003843.433BA1AEE88@zion.home.lan> <14927.1117200829@redhat.com>
In-Reply-To: <14927.1117200829@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505281319.52153.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [patch 4/8] irq code: Add coherence test for
	PREEMPT_ACTIVE
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
Date: Sat, 28 May 2005 13:19:51 +0200
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linuxsh-shmedia-dev@lists.sourceforge.net, linux-sh@m17n.org

On Friday 27 May 2005 15:33, David Howells wrote:
> Blaisorblade <blaisorblade@yahoo.it> wrote:
> > Ok, a grep shows that possible culprits (i.e. giving success to
> > grep GENERIC_HARDIRQS arch/*/Kconfig, and using 0x4000000 as
> > PREEMPT_ACTIVE, as given by grep PREEMPT_ACTIVE
> > include/asm-*/thread_info.h) are (at a first glance): frv, sh, sh64.
>
> For FRV that's simply because it got copied from the parent arch along with
> other stuff. Feel free to move it... Do you want me to make you up a patch
> to do so?
Sorry but fix that yourself, otherwise you get a chance I'll forget since I'm 
quite busy.

Thanks a lot for attention.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
