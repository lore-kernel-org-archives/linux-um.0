Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guQsT-0005jl-Ha
 for linux-um@lists.infradead.org; Thu, 14 Feb 2019 23:57:14 +0000
Received: by mail-pf1-x441.google.com with SMTP id q1so3913341pfi.5
 for <linux-um@lists.infradead.org>; Thu, 14 Feb 2019 15:57:13 -0800 (PST)
Subject: Re: [RFC v3 18/19] of: unittest: split out a couple of test cases
 from unittest
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-19-brendanhiggins@google.com>
 <990bfc7d-dc5e-d8d3-c151-9b321ff2ac10@gmail.com>
 <CAFd5g45tOGgf_sKGYRC=fpnTBKGaG=8frbQdgZ3ZTkQFyTfP5A@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <88fe0546-7850-5bb4-9673-b1aef2dccb3e@gmail.com>
Date: Thu, 14 Feb 2019 15:57:09 -0800
MIME-Version: 1.0
In-Reply-To: <CAFd5g45tOGgf_sKGYRC=fpnTBKGaG=8frbQdgZ3ZTkQFyTfP5A@mail.gmail.com>
Content-Language: en-US
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mcgrof@kernel.org, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On 12/5/18 3:54 PM, Brendan Higgins wrote:
> On Tue, Dec 4, 2018 at 2:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> Hi Brendan,
>>
>> On 11/28/18 11:36 AM, Brendan Higgins wrote:
>>> Split out a couple of test cases that these features in base.c from the
>>> unittest.c monolith. The intention is that we will eventually split out
>>> all test cases and group them together based on what portion of device
>>> tree they test.
>>
>> Why does splitting this file apart improve the implementation?
> 
> This is in preparation for patch 19/19 and other hypothetical future
> patches where test cases are split up and grouped together by what
> portion of DT they test (for example the parsing tests and the
> platform/device tests would probably go separate files as well). This
> patch by itself does not do anything useful, but I figured it made
> patch 19/19 (and, if you like what I am doing, subsequent patches)
> easier to review.

I do not see any value in splitting the devicetree tests into
multiple files.

Please help me understand what the benefits of such a split are.

Thanks,

Frank

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

