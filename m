Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuUSA-00Grvu-Bi
	for linux-um@lists.infradead.org; Fri, 27 May 2022 07:32:12 +0000
Message-ID: <1f0e79c925f79fba884ec905cf55a3eb7b602d48.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 27 May 2022 09:32:03 +0200
In-Reply-To: <CACT4Y+a191xbPi_0w6imTAYHDeAoudrxbWiuERBOk41e5q_K_Q@mail.gmail.com>
References: <20220525111756.GA15955@axis.com>
	 <20220526010111.755166-1-davidgow@google.com>
	 <CACT4Y+a191xbPi_0w6imTAYHDeAoudrxbWiuERBOk41e5q_K_Q@mail.gmail.com>
MIME-Version: 1.0
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
To: Dmitry Vyukov <dvyukov@google.com>, David Gow <davidgow@google.com>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, anton.ivanov@cambridgegreys.com, Brendan Higgins <brendanhiggins@google.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Daniel Latypov <dlatypov@google.com>

On Fri, 2022-05-27 at 07:31 +0200, Dmitry Vyukov wrote:
> > - This doesn't seem to work when CONFIG_STATIC_LINK is enabled (because
> >   libc crt0 code calls memory functions, which expect the shadow memory
> >   to already exist, due to multiple symbols being resolved.
> >   - I think we should just make this depend on dynamic UML.
> >   - For that matter, I think static UML is actually broken at the
> >     moment. I'll send a patch out tomorrow.
> 
> I don't know how important the static build is for UML.

Depends who you ask, I guess.

IMHO just making KASAN depend on !STATIC_LINK is fine, until somebody
actually wants to do what you describe:

> Generally I prefer to build things statically b/c e.g. if a testing
> system builds on one machine but runs tests on another, dynamic link
> may be a problem. Or, say, if a testing system provides binary
> artifacts, and then nobody can run it locally.
> 
> One potential way to fix it is to require outline KASAN
> instrumentation for static build and then make kasan_arch_is_ready()
> return false until the shadow is mapped. I see kasan_arch_is_ready()
> is checked at the beginning of all KASAN runtime entry points.
> But it would be nice if the dynamic build also supports inline and
> does not add kasan_arch_is_ready() check overhead.

which sounds fine too, but ... trade-offs.

> > +       if (IS_ENABLED(CONFIG_UML)) {
> > +               __memset(kasan_mem_to_shadow((void *)addr), KASAN_VMALLOC_INVALID, shadow_end - shadow_start);
> 
> "kasan_mem_to_shadow((void *)addr)" can be replaced with shadow_start.

and then the memset line isn't so long anymore :)

> 
> 
> > +               return 0;
> > +       }
> > +
> > +       shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
> >         shadow_end = ALIGN(shadow_end, PAGE_SIZE);
> 
> There is no new fancy PAGE_ALIGN macro for this. And I've seen people

s/no/now the/ I guess, but it's also existing code.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

