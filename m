Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEHRq-0002Yh-At
 for linux-um@lists.infradead.org; Tue, 17 Mar 2020 19:00:20 +0000
Received: by mail-pg1-x543.google.com with SMTP id h8so12226946pgs.9
 for <linux-um@lists.infradead.org>; Tue, 17 Mar 2020 12:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <1584466534-13248-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1584466534-13248-1-git-send-email-alan.maguire@oracle.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 17 Mar 2020 12:00:03 -0700
Message-ID: <CAFd5g46AZC7EPgxfTRdws_4u6V=AxCGASG7jxCJXuXU=hJUxog@mail.gmail.com>
Subject: Re: [PATCH] arch/um: falloc.h needs to be directly included for older
 libc
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Johannes Berg <johannes.berg@intel.com>, erelx.geron@intel.com, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, alex.dewar@gmx.co.uk, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Tue, Mar 17, 2020 at 10:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> When building UML with glibc 2.17 installed, compilation
> of arch/um/os-Linux/file.c fails due to failure to find
> FALLOC_FL_PUNCH_HOLE and FALLOC_FL_KEEP_SIZE definitions.
>
> It appears that /usr/include/bits/fcntl-linux.h (indirectly
> included by /usr/include/fcntl.h) does not include falloc.h
> with an older glibc, whereas a more up-to-date version
> does.
>
> Adding the direct include to file.c resolves the issue
> and does not cause problems for more recent glibc.
>
> Fixes: 50109b5a03b4 ("um: Add support for DISCARD in the UBD Driver")
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

