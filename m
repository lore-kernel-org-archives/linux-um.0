Return-Path: <elver@google.com>
MIME-Version: 1.0
References: <20210714143239.2529044-1-geert@linux-m68k.org> <CAMuHMdWv8-6fBDLb8cFvvLxsb7RkEVkLNUBeCm-9yN9_iJkg-g@mail.gmail.com>
In-Reply-To: <CAMuHMdWv8-6fBDLb8cFvvLxsb7RkEVkLNUBeCm-9yN9_iJkg-g@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 14 Jul 2021 17:06:23 +0200
Message-ID: <CANpmjNO7reWQQCce+grJsfEjNcGzvrrsF2450DhE4CzCkvFt0w@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.14-rc1
Content-Type: text/plain; charset="UTF-8"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steen Hegelund <Steen.Hegelund@microchip.com>, linux-um <linux-um@lists.infradead.org>, scsi <linux-scsi@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, netdev <netdev@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Wed, 14 Jul 2021 at 16:44, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
[...]
>   + /kisskb/src/include/linux/compiler_attributes.h: error:
> "__GCC4_has_attribute___no_sanitize_coverage__" is not defined
> [-Werror=undef]:  => 29:29

https://lkml.kernel.org/r/20210714150159.2866321-1-elver@google.com

Thanks for the report.

