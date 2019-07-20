Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hodtr-0004gu-SI
 for linux-um@lists.infradead.org; Sat, 20 Jul 2019 01:11:01 +0000
Received: by mail-pg1-x543.google.com with SMTP id u17so15162798pgi.6
 for <linux-um@lists.infradead.org>; Fri, 19 Jul 2019 18:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190718012136.GA135592@google.com>
In-Reply-To: <20190718012136.GA135592@google.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 19 Jul 2019 18:10:44 -0700
Message-ID: <CAFd5g46YthkN=8Qsdb330b1Z2E=qadT3iW6WFz1FFvrAi7Oydw@mail.gmail.com>
Subject: Re: UML GCOV fails to produce *.gcda files
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Darya Verzhbinsky <daryaver@google.com>, Daniel Latypov <dlatypov@google.com>, Maria Ignacio <mariaignacio@google.com>, linux-um@lists.infradead.org

On Wed, Jul 17, 2019 at 6:21 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Following the instructions here[1], we have been trying to get gcov
> support working under UML. However, despite the fact that it seems to be
> configured correctly (I see it producing *.gcno files), it does not
> appear to be producing *.gcda files (or *.da) files when we run the UML
> kernel.
>
> Sor far we have mostly been working with v5.2.
>
> Running make with KBUILD_VERBOSE=1 we see that gcc is being called with
> the appropriate gcov flags: -fprofile-arcs -ftest-coverage
>
> As I mentioned above, we see that *.gcno files are being produced.
>
> We also see that libgcov is being linked into the linux binary:
>
> readelf -s linux | grep __gcov_init
>  29312: 000000006041d070   200 FUNC    GLOBAL HIDDEN    13 __gcov_init
>
> To ensure that __gcov_flush() is actually being called, we manually
> inserted it in the kernel's init (just to see if we get some coverage
> information). I copied the patch at the end of this email.
>
> And yet we still see no *.gcda files being generated.
>
> It looks like it has been a very long time since anyone has touched the
> UML gcov code, so I have started looking into building an older version
> of the kernel where it might have worked, but have not gotten any useful
> results back from that yet.

I have an update on this!

I tried building the kernel with gcc-4.9.4 when I discovered that gcov
*does* work with v5.2 of the kernel, just not gcc-7.3.0. So it seems
this may actually be an issue with gcc and not UML.

I will update when I learn more.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

