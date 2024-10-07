import UIKit

protocol IMealDetailView: AnyObject {
    func setMeal(title: String?, image: String?, description: String?)
    func showLoadingView()
    func dismissLoadingView()
}

class MealDetailViewController: UIViewController {
    
    //MARK: - PROPERTIES
    var mealId: String?
    private let vm = MealDetailViewModel()
    
    //MARK: - UI ELEMENTS
    private lazy var mealNamelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "food-placeholder")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private lazy var mealDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackview: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [mealNamelabel, mealImageView, mealDescriptionLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = true
        scroll.isScrollEnabled = true
        return scroll
    }()
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSubViews()
        vm.setDelegate(self)
        vm.setMealId(mealId)
        Task {await vm.fetchMealDetail()}
    }
    
}

//MARK: - HElPER FUNCTIONS
extension MealDetailViewController {
    
    func setUpSubViews() {
        navigationController?.navigationBar.prefersLargeTitles = false
        view.addSubview(scrollView)
        scrollView.addSubview(stackview)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackview.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackview.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            mealImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}

//MARK: - IMEALDETAILVIEW
extension MealDetailViewController: IMealDetailView {
    
    func setMeal(title: String?, image: String?, description: String?) {
        guard let title = title, let image = image, let description = description else { return }
        mealDescriptionLabel.text = description
        mealNamelabel.text = title
        mealImageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "food-placeholder"), completed: nil)
        
    }
    
    func showLoadingView() {
        self.showActivity()
    }
    
    func dismissLoadingView() {
        self.removeActivity()
    }
    
}


