Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMHMU-001uup-5l
 for linux-um@lists.infradead.org; Tue, 16 Mar 2021 21:36:23 +0000
Message-ID: <83c63df46b2a3d710a5ad48478ae12cefba44433.camel@sipsolutions.net>
Subject: Re: [RFC v8 13/20] um: lkl: integrate with irq infrastructure of UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 16 Mar 2021 22:36:19 +0100
In-Reply-To: <m21rcfc2sy.wl-thehajime@gmail.com>
 (sfid-20210316_022016_788128_95241D90)
References: <cover.1611103406.git.thehajime@gmail.com>
 <46935454bf02224fb325f0e74d60d0ed674a59f9.1611103406.git.thehajime@gmail.com>
 <5e1f64997ffca8267bde7955fe2eb214dfb9e891.camel@sipsolutions.net>
 <m21rcfc2sy.wl-thehajime@gmail.com> (sfid-20210316_022016_788128_95241D90)
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, retrage01@gmail.com

On Tue, 2021-03-16 at 10:20 +0900, Hajime Tazaki wrote:
> 
> > > -	if (sigprocmask(SIG_UNBLOCK, &sig_mask, NULL) < 0)
> > > -		panic("sigprocmask failed - errno = %d\n", errno);
> > > +	if (pthread_sigmask(SIG_UNBLOCK, &sig_mask, NULL) < 0)
> > > +		panic("pthread_sigmask failed - errno = %d\n", errno);
> > 
> > UML doesn't normally link with libpthread, and LKL doesn't actually
> > appear to require it either (since it has its lkl_thread and all), so
> > this seems wrong?
> 
> I think both UML/LKL link with libpthread.  See old
> scripts/link-vmlinux.sh, or [01/20] patch.
> 
> -		${CC} ${CFLAGS_vmlinux}				\
> -			${strip_debug}				\
> -			-o ${output}				\
> -			-Wl,-T,${lds}				\
> -			${objects}				\
> -			-lutil -lrt -lpthread
> -		rm -f linux

Interesting. You're right, I really didn't expect that, nor did I ever
see that before.

How does this interact with all the clone() calls etc. that UML does?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

