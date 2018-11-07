Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKRuq-0004Rq-1A
 for linux-um@lists.infradead.org; Wed, 07 Nov 2018 17:46:57 +0000
Received: by mail-pf1-x442.google.com with SMTP id v68-v6so4416508pfk.0
 for <linux-um@lists.infradead.org>; Wed, 07 Nov 2018 09:46:45 -0800 (PST)
Subject: Re: [RFC v2 00/14] kunit: introduce KUnit, the Linux kernel unit
 testing framework
References: <20181023235750.103146-1-brendanhiggins@google.com>
 <f3682d48-6f27-5eef-8274-02f90dd65188@kernel.org>
 <CAFd5g45Tgcx4RisrCF8QHneR7ELezPfpEPKh_mH8KEUi3skE7g@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <04f677b1-bc44-f004-cf2a-51b47baf0965@gmail.com>
Date: Wed, 7 Nov 2018 09:46:41 -0800
MIME-Version: 1.0
In-Reply-To: <CAFd5g45Tgcx4RisrCF8QHneR7ELezPfpEPKh_mH8KEUi3skE7g@mail.gmail.com>
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
To: Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, Rob Herring <robh@kernel.org>, linux-nvdimm@lists.01.org, richard@nod.at, kieran.bingham@ideasonboard.com, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mcgrof@kernel.org, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On 11/6/18 5:17 PM, Brendan Higgins wrote:
> On Fri, Nov 2, 2018 at 11:23 AM Shuah Khan <shuah@kernel.org> wrote:
>>
>> Hi Brendan,
> <snip>
>> Framework looks good. I think it would be helpful to include a real test
> 
> Great to hear!
> 
>> in the patch series to get a feel for how effective it is.
> 
> Alright, will do. Rob suggested converting
> https://elixir.bootlin.com/linux/v4.19/source/drivers/of/unittest.c to
> KUnit, so that might offer a good comparison.

drivers/of/unittest.c might be a bit bigger and more complex test than
you want to start with.

-Frank

< snip >

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

