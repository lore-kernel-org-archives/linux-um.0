Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQAz2-0001DO-MR
 for linux-um@lists.infradead.org; Wed, 07 Oct 2020 15:04:01 +0000
Message-ID: <3f0aab8f38971360240e1e04bd6b90a8dcadec86.camel@sipsolutions.net>
Subject: Re: [RFC v7 18/21] um: host: add utilities functions
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 07 Oct 2020 17:03:24 +0200
In-Reply-To: <6d8dd929722e419894824a07792ac8c5b2659de9.camel@sipsolutions.net>
References: <cover.1601960644.git.thehajime@gmail.com>
 <7a39c85a38658227d3daf6443babb7733d1a1ff4.1601960644.git.thehajime@gmail.com>
 <27868819-fbd7-9eec-0520-d2fb9b6bf4a6@cambridgegreys.com>
 <6d8dd929722e419894824a07792ac8c5b2659de9.camel@sipsolutions.net>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, retrage01@gmail.com, linux-arch@vger.kernel.org

On Wed, 2020-10-07 at 17:02 +0200, Johannes Berg wrote:
> On Wed, 2020-10-07 at 15:53 +0100, Anton Ivanov wrote:
> > These are actually different on different architectures. These look
> > like the x86 values.
> > 
> > IMHO a kernel strerror() would be the right way of dealing with this
> > in the long term (i understand that we cannot call the platform one,
> > because it may be different from the internal Linux errors). It will
> > be useful in a lot of other places.
> > 
> > If we leave it as is, we need to make this arch specific at some
> > point.
> > 
> > > +
> > > +static const char * const lkl_err_strings[] = {
> > > +	"Success",
> > > +	"Operation not permitted",
> 
> Might be possible to more or less address this (except for arch-specific 
> errors that don't always exist) but using C99 initializers?
> 
> [0] = "Success",
> [EPERM] = "Operation not permitted",
> ..

But, on the other hand, is it needed at all? I don't think the kernel
ever prints out the actual string ...

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

