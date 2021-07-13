Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3O32-00BDf1-Be
 for linux-um@lists.infradead.org; Tue, 13 Jul 2021 19:26:29 +0000
Message-ID: <8c377addaa42a7dd3bbe047e1f744a51103e6ff2.camel@sipsolutions.net>
Subject: Re: UML kernel panic on initialization
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 13 Jul 2021 21:26:18 +0200
In-Reply-To: <6442ec0e5e2cf55990b43ff178023fd6050e63fb.camel@sipsolutions.net>
References: <a6188b0422c2a8fe1b5e9f164bfa1796@codeaurora.org>
 <6442ec0e5e2cf55990b43ff178023fd6050e63fb.camel@sipsolutions.net>
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
To: subashab@codeaurora.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org

On Tue, 2021-07-13 at 21:22 +0200, Johannes Berg wrote:
> On Sat, 2021-07-10 at 15:00 -0600, subashab@codeaurora.org wrote:
> > 
> > I have reverted the following patches (to allow for a clean revert)
> > and I don't see the panic anymore -
> > 
> > bfc58e2b98e99737409cd9f4d86a79677c5b887c
> > dc01a3b9db43abf95b801c9694980777a329e303
> > 9f0b4807a44ff81cf59421c8a86641efec586610
> > 84b2789d61156db0224724806b20110c0d34b07c
> 
> Out of those 4, the last ("separate child and...") seems actually less
> intrusive than the previous one. If you revert only the first three of
> this list, does it still happen?
> 
> Does it still happen if you unset CONFIG_CC_OPTIMIZE_FOR_SIZE and do
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE instead?

Oh, and it looks like 84b2789d6115 actually got some bits that shouldn't
have been there!

Assuming it does *not* work with just the first three patches reverted,
does it work again if you revert the first three patches, and only this
bit of the fourth?

--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -24,29 +24,26 @@
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_clone_handler(void)
 {
-       struct stub_data *data = (struct stub_data *) STUB_DATA;
+       int stack;
+       struct stub_data *data = (void *) ((unsigned long)&stack & ~(UM_KERN_PAGE_SIZE - 1));
        long err;



I think we probably have some miscompilation again with this thing - I
saw a bunch of similar issues with our syscall stubs at some point, and
I'm not sure we got it all right already.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

