Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
MIME-Version: 1.0
References: <20190322132108.25501-1-sakari.ailus@linux.intel.com>
 <20190322132108.25501-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0i8JiQGk25yZKQqTzCCY+nrfoKXOH8nM6eNPhkN-i+y9w@mail.gmail.com>
In-Reply-To: <CAJZ5v0i8JiQGk25yZKQqTzCCY+nrfoKXOH8nM6eNPhkN-i+y9w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Mar 2019 10:49:01 +0100
Message-ID: <CAJZ5v0ixukjWzSUqNCOpYuQci=7+ctdEhdZwOh=afz1b2zFVaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vsprintf: Remove support for %pF and %pf in favour of
 %pS and %ps
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, netdev <netdev@vger.kernel.org>, linux-btrfs@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, ceph-devel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Memory Management List <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, drbd-dev@lists.linbit.com
List-ID: <linux-um.lists.infradead.org>

On Mon, Mar 25, 2019 at 10:30 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Mar 22, 2019 at 2:21 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > %pS and %ps are now the preferred conversion specifiers to print function
> > %names. The functionality is equivalent; remove the old, deprecated %pF
> > %and %pf support.
>
> Are %pF and %pf really not used any more in the kernel?
>
> If that is not the case, you need to convert the remaining users of
> them to using %ps or %pS before making support for them go away
> completely.

Well, this is a [2/2] in a series, sorry for the noise (/me blames
gmail for the confusion).

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

