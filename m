Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4F38DA79.2040803@suse.cz>
Date: Mon, 13 Feb 2012 10:40:09 +0100
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
References: <1329006070-4275-1-git-send-email-richard@nod.at> <20120212010211.GN23916@ZenIV.linux.org.uk> <4F37B34F.1040307@suse.cz> <20120212190611.GP23916@ZenIV.linux.org.uk>
In-Reply-To: <20120212190611.GP23916@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: your mail
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Jiri Slaby <jirislaby@gmail.com>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, gregkh@linuxfoundation.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 02/12/2012 08:06 PM, Al Viro wrote:
> Yecchhh...  If I'm reading (and grepping) it right, there are only two
> non-default instance of tty_operations ->shutdown() - pty and vt ones.
> Lovely...  And while we are at it, vt instance is definitely not safe
> from interrupts - calls console_lock().  Not that it was relevant in
> this case...

Thanks for looking into that. I was too lazy to do that on Sunday.

You're right that it may cause problems. Fortunately vt doesn't refcount
ttys. Hence con_shutdown can be called only from release_tty (close
path) in the user context.

Adding to my TODO list, unless somebody beats me to fix it.

thanks,
-- 
js
suse labs
