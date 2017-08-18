using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class DTOBase
    {
        private bool _isNew = false;
        private bool _isDirty = false;
        private bool _isDeleted = false;
        public bool IsNew
        {
            get { return _isNew; }
            set { _isNew = value; }
        }
        public bool IsDirty
        {
            get { return _isDirty; }
            set { _isDirty = value; }
        }
        public bool IsDeleted
        {
            get { return _isDeleted; }
            set { _isDeleted = value; }
        }
    }
}
