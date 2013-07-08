Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <51DB20CB.9020706@nod.at>
Date: Mon, 08 Jul 2013 22:27:55 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <51DB1EE5.5040108@google.com>
In-Reply-To: <51DB1EE5.5040108@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCHv3] uml: Fix which_tmpdir failure when /dev/shm is a symlink,
 and in other edge cases
To: Tristan Schmelcher <tschmelcher@google.com>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 08.07.2013 22:19, schrieb Tristan Schmelcher:
> From: Tristan Schmelcher <tschmelcher@google.com>
> 
> which_tmpdir did the wrong thing if /dev/shm was a symlink (e.g., to /run/shm),
> if there were multiple mounts on top of each other, if the mount(s) were
> obscured by a later mount, or if /dev/shm was a prefix of another mount point.
> This fixes these cases. Applies to 3.9.6.
> 
> Signed-off-by: Tristan Schmelcher <tschmelcher@google.com>

Is this just a resend or did your alter the patch you sent me already?
I'm about to send my UML patches to Linus tomorrow.

Thanks,
//richard
