Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLXtT-00EXzw-QL
 for linux-um@lists.infradead.org; Sun, 14 Mar 2021 21:03:25 +0000
Message-ID: <d357fbd075319d8b32667323bc545e3e5e8e8a21.camel@sipsolutions.net>
Subject: Re: [RFC v8 00/20] Unifying LKL into UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 14 Mar 2021 22:03:19 +0100
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
 <cover.1611103406.git.thehajime@gmail.com>
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
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, retrage01@gmail.com

Hi,

So I'm still a bit lost here with this, and what exactly you're doing in
places.

For example, you simulate a single CPU ("depends on !SMP", and anyway
UML only supports that right now), yet on the other hand do a *LOT* of
extra work with lkl_sem, lkl_thread, lkl_mutex, and all that. It's not
clear to me why? Are you trying to model kernel threads as actual
userspace pthreads, but then run only one at a time by way of exclusive
locking?

I think we probably need a bit more architecture introduction here in
the cover letter or the documentation patch. The doc patch basically
just explains what it does, but not how it does anything, or why it was
done in this way.

For example, I'm asking myself:
 * Why NOMMU? UML doesn't really do _much_ with memory protection unless
   you add userspace, which you don't have.
 * Why pthreads and all? You already require jump_buf, so UML's
   switch_threads() ought to be just fine for scheduling? It almost
   seems like you're doing this just so you can serialize against "other
   threads" (application threads), but wouldn't that trivially be
   handled by the application? You could let it hook into switch_to() or
   something, but why should a single "LKL" CPU ever require multiple
   threads? Seems to me that the userspace could be required to
   "lkl_run()" or so (vs. lkl_start()). Heck, you could even exit
   lkl_run() every time you switch tasks in the kernel, and leave
   scheduling the kernel vs. the application entirely up to the
   application? (A trivial application would be simply doing something
   like "while (1) { lkl_run(); pause(); }" mimicking the idle loop of
   UML.

And - kind of the theme behind all these questions - why is this not
making UML actually be a binary that uses LKL? If the design were like
what I'm alluding to above, that should actually be possible? Why should
it not be possible? Why would it not be desirable? (I'm actually
thinking that might be really useful to some of the things I'm doing.)
Yes, if the application actually supports userspace running then it has
som limitations on what it can do (in particular wrt. signals etc.), but
that could be documented and would be OK?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

