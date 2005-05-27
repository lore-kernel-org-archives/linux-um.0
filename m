Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200505270306.09425.blaisorblade@yahoo.it> 
References: <200505270306.09425.blaisorblade@yahoo.it>
	<20050527003843.433BA1AEE88@zion.home.lan> 
Message-ID: <14927.1117200829@redhat.com>
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
Date: Fri, 27 May 2005 14:33:49 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linuxsh-shmedia-dev@lists.sourceforge.net, linux-sh@m17n.org

Blaisorblade <blaisorblade@yahoo.it> wrote:

> Ok, a grep shows that possible culprits (i.e. giving success to
> grep GENERIC_HARDIRQS arch/*/Kconfig, and using 0x4000000 as PREEMPT_ACTIVE, 
> as given by grep PREEMPT_ACTIVE include/asm-*/thread_info.h) are (at a first 
> glance): frv, sh, sh64.

For FRV that's simply because it got copied from the parent arch along with
other stuff. Feel free to move it... Do you want me to make you up a patch to
do so?

David


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
