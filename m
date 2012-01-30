Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 30 Jan 2012 18:23:33 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20120130182333.GK23916@ZenIV.linux.org.uk>
References: <1327512234-22578-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1327512234-22578-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] um: Use generic io.h
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Jan 25, 2012 at 06:23:53PM +0100, Richard Weinberger wrote:
> There is no need to implement our own basic io functions.
> All we need exists already in asm-generic/io.h

Then just do

git rm arch/um/include/asm/io.h
echo 'generic-y += io.h' >>arch/um/include/asm/Kbuild
git add arch/um/include/asm/Kbuild

and be done with that.  We are already using generic-y for a bunch of
headers there...
