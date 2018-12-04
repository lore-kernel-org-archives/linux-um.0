Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8Pd-0007jK-Fv
 for linux-um@lists.infradead.org; Tue, 04 Dec 2018 10:58:46 +0000
Received: by mail-pg1-x541.google.com with SMTP id y4so7192497pgc.12
 for <linux-um@lists.infradead.org>; Tue, 04 Dec 2018 02:58:35 -0800 (PST)
Subject: Re: [RFC v3 18/19] of: unittest: split out a couple of test cases
 from unittest
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-19-brendanhiggins@google.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <990bfc7d-dc5e-d8d3-c151-9b321ff2ac10@gmail.com>
Date: Tue, 4 Dec 2018 02:58:28 -0800
MIME-Version: 1.0
In-Reply-To: <20181128193636.254378-19-brendanhiggins@google.com>
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
To: Brendan Higgins <brendanhiggins@google.com>, gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org, shuah@kernel.org
Cc: brakmo@fb.com, robh@kernel.org, knut.omang@oracle.com, richard@nod.at, dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org, mpe@ellerman.id.au, Tim.Bird@sony.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, kieran.bingham@ideasonboard.com, julia.lawall@lip6.fr, joel@jms.id.au, linux-kselftest@vger.kernel.org, khilman@baylibre.com, joe@perches.com, daniel@ffwll.ch, dan.j.williams@intel.com, jdike@addtoit.com, kunit-dev@googlegroups.com

Hi Brendan,

On 11/28/18 11:36 AM, Brendan Higgins wrote:
> Split out a couple of test cases that these features in base.c from the
> unittest.c monolith. The intention is that we will eventually split out
> all test cases and group them together based on what portion of device
> tree they test.

Why does splitting this file apart improve the implementation?


> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/of/Makefile      |   2 +-
>  drivers/of/base-test.c   | 214 ++++++++++++++++++++++++++
>  drivers/of/test-common.c | 149 ++++++++++++++++++
>  drivers/of/test-common.h |  16 ++
>  drivers/of/unittest.c    | 316 +--------------------------------------
>  5 files changed, 381 insertions(+), 316 deletions(-)
>  create mode 100644 drivers/of/base-test.c
>  create mode 100644 drivers/of/test-common.c
>  create mode 100644 drivers/of/test-common.h
>
< snip >

-Frank

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

