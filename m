Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-f175.google.com ([209.85.214.175])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSZge-0004tQ-1N
 for linux-um@lists.infradead.org; Fri, 30 Nov 2018 03:41:53 +0000
Received: by mail-pl1-f175.google.com with SMTP id b5so2100150plr.4
 for <linux-um@lists.infradead.org>; Thu, 29 Nov 2018 19:41:41 -0800 (PST)
Date: Thu, 29 Nov 2018 19:41:35 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC v3 08/19] arch: um: add shim to trap to allow installing a
 fault catcher for tests
Message-ID: <20181130034135.GN18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-9-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128193636.254378-9-brendanhiggins@google.com>
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
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, frowand.list@gmail.com, linux-nvdimm@lists.01.org, richard@nod.at, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, joel@jms.id.au, jdike@addtoit.com, Tim.Bird@sony.com, keescook@google.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Wed, Nov 28, 2018 at 11:36:25AM -0800, Brendan Higgins wrote:
> +static void segv_run_catcher(jmp_buf *catcher, void *fault_addr)
> +{
> +	current->thread.fault_addr = fault_addr;
> +	UML_LONGJMP(catcher, 1);
> +}

Some documentation about what this does exactly would be appreciated.
With the goal it may be useful to others wanting to consider support
for other archs -- if that actually ends up being desirable.

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

