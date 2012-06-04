Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4FCCD70D.5010908@suse.cz>
Date: Mon, 04 Jun 2012 17:41:01 +0200
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
References: <1338809738-18967-1-git-send-email-jslaby@suse.cz> <1338809738-18967-14-git-send-email-jslaby@suse.cz> <4FCCA3A6.8080608@nod.at> <4FCCD224.1020307@suse.cz> <4FCCD44A.3090500@nod.at>
In-Reply-To: <4FCCD44A.3090500@nod.at>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 13/24] TTY: um/line, use tty from tty_port
To: Richard Weinberger <richard@nod.at>
Cc: Jiri Slaby <jirislaby@gmail.com>, gregkh@linuxfoundation.org, alan@linux.intel.com, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 06/04/2012 05:29 PM, Richard Weinberger wrote:
> It looks like that it solves UML's TTY issues with systemd distros.
> :-)

Good.

>> So the switch of the driver to the new tty port API, as suggested
>> by Alan, is still needed. I might do that later if I learn how to
>> make UML work. (The conversion is by definition invasive and
>> needs runtime testing.)
> 
> Two days ago I did so but still faced the problems described here: 
> https://lkml.org/lkml/2012/3/10/163

Hmm, I remember. I suggest you to split the patch into several pieces.
For example moving the code from ->open into ->install can be done
separately. Otherwise it's hard to tell what's wrong with the patch as
a whole.

Also, it would be good to see the patch rebased on the top of my
patch, because tty_port_set/get pieces would be gone from your patch too.

regards,
-- 
js
suse labs


