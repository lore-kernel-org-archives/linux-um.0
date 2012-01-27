Return-Path: <BATV+cb6efe93f59108224520+3078+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 27 Jan 2012 13:20:17 -0500
From: Christoph Hellwig <hch@infradead.org>
Message-ID: <20120127182016.GA15705@infradead.org>
References: <y>
 <1327688098-10159-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1327688098-10159-1-git-send-email-geert@linux-m68k.org>
Subject: Re: [PATCH] uml/hostfs: Propagate dirent.d_type to filldir()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Jan 27, 2012 at 07:14:58PM +0100, Geert Uytterhoeven wrote:
> Currently the (optional) d_type member in struct dirent is always
> DT_UNKNOWN on hostfs, which may confuse buggy software using readdir().
> Make sure to propagate its value from the underlying filesystem if it's
> available there.

What software would that be?  We have lots of filesystems not filling
in d_type, and several operating systems don't have it at all.


