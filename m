Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQhl6-0002Pz-R9
 for linux-um@lists.infradead.org; Wed, 15 May 2019 00:27:02 +0000
References: <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
 <20190509233043.GC20877@mit.edu>
 <8914afef-1e66-e6e3-f891-5855768d3018@deltatee.com>
 <6d6e91ec-33d3-830b-4895-4d7a20ba7d45@gmail.com>
 <3faa022b-0b70-0375-aa6d-12ea83a2671f@deltatee.com>
 <d148a554-2a71-a5a4-4bb2-d84d2c483277@gmail.com>
 <20190514083819.GC230665@google.com>
 <5ff098a9-9424-901c-9017-d4492e306528@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8c693b9f-43ec-8982-825c-cabfd61b659d@deltatee.com>
Date: Tue, 14 May 2019 18:26:11 -0600
MIME-Version: 1.0
In-Reply-To: <5ff098a9-9424-901c-9017-d4492e306528@gmail.com>
Content-Language: en-CA
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
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
To: Frank Rowand <frowand.list@gmail.com>, Brendan Higgins <brendanhiggins@google.com>
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>, richard@nod.at, sboyd@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org



On 2019-05-14 6:14 p.m., Frank Rowand wrote:
> The high level issue is to provide reviewers with enough context to be
> able to evaluate the patch series.  That is probably not very obvious
> at this point in the thread.  At this point I was responding to Logan's
> response to me that I should be reading Documentation to get a better
> description of KUnit features.  I _think_ that Logan thought that I
> did not understand KUnit features and was trying to be helpful by
> pointing out where I could get more information.  If so, he was missing
> my intended point had been that patch 0 should provide more information
> to justify adding this feature.

Honestly, I lost track of wait exactly your point was. And, in my
opinion, Brendan has provided over and above the information required to
justify Kunit's inclusion.

> One thing that has become very apparent in the discussion of this patch
> series is that some people do not understand that kselftest includes
> in-kernel tests, not just userspace tests.  As such, KUnit is an
> additional implementation of "the same feature".  (One can debate
> exactly which in-kernel test features kselftest and KUnit provide,
> and how much overlap exists or does not exist.  So don't take "the
> same feature" as my final opinion of how much overlap exists.)  So
> that is a key element to be noted and explained.

From my perspective, once we were actually pointed to the in-kernel
kselftest code and took a look at it, it was clear there was no
over-arching framework to them and that Kunit could be used to
significantly improve those tests with a common structure. Based on my
reading of the thread, Ted came to the same conclusion.

I don't think we should block this feature from being merged, and for
future work, someone can update the in-kernel kselftests to use the new
framework.

Logan

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

