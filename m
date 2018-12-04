Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8NP-0007WN-U2
 for linux-um@lists.infradead.org; Tue, 04 Dec 2018 10:56:29 +0000
Received: by mail-pf1-x441.google.com with SMTP id i12so8022950pfo.7
 for <linux-um@lists.infradead.org>; Tue, 04 Dec 2018 02:56:17 -0800 (PST)
Subject: Re: [RFC v3 17/19] of: unittest: migrate tests to run on KUnit
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-18-brendanhiggins@google.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <630d0c82-401e-28f8-73fc-6e684ec57bbf@gmail.com>
Date: Tue, 4 Dec 2018 02:56:10 -0800
MIME-Version: 1.0
In-Reply-To: <20181128193636.254378-18-brendanhiggins@google.com>
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

On 11/28/18 11:36 AM, Brendan Higgins wrote:
> Migrate tests without any cleanup, or modifying test logic in anyway to
> run under KUnit using the KUnit expectation and assertion API.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/of/Kconfig    |    1 +
>  drivers/of/unittest.c | 1405 ++++++++++++++++++++++-------------------
>  2 files changed, 752 insertions(+), 654 deletions(-)

< snip >

I am travelling and will not have an opportunity to properly review this
patch, patch 18, or patch 19 until next week.

-Frank


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

